class Address < ApplicationRecord
  PREFIX_MAINNET = "ckb".freeze
  PREFIX_TESTNET = "ckt".freeze

  has_many :cell_outputs, dependent: :destroy
  has_many :account_books, dependent: :destroy
  has_many :ckb_transactions, through: :account_books
  has_many :mining_infos
  has_many :udt_accounts
  validates :balance, :cell_consumed, :ckb_transactions_count, :interest, :dao_deposit, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  scope :visible, -> { where(visible: true) }
  scope :created_after, ->(block_timestamp) { where("block_timestamp >= ?", block_timestamp) }
  scope :created_before, ->(block_timestamp) { where("block_timestamp <= ?", block_timestamp) }

  after_commit :flush_cache

  attr_accessor :query_address

  def custom_ckb_transactions
    CkbTransaction.where("contained_address_ids @> array[?]::bigint[]", [id])
  end

  def ckb_dao_transactions
    CkbTransaction.where("dao_address_ids @> array[?]::bigint[]", [id])
  end

  def ckb_udt_transactions(udt_id)
    CkbTransaction.where("udt_address_ids @> array[?]::bigint[]", [id]).where("contained_udt_ids @> array[?]::bigint[]", [udt_id])
  end

  def lock_info
    lock_script.lock_info
  end

  def lock_script
    Rails.cache.realize(["Address", "lock_script", id], race_condition_ttl: 3.seconds) do
      LockScript.where(address: self).first
    end
  end

  def self.find_or_create_address(lock_script, block_timestamp)
    address_hash = CkbUtils.generate_address(lock_script)
    lock_hash = lock_script.compute_hash
    address = Address.find_or_create_by!(address_hash: address_hash, lock_hash: lock_hash)
    address.update(block_timestamp: block_timestamp) if address.block_timestamp.blank?

    address
  end

  def self.find_address!(query_key)
    cached_find(query_key) || raise(Api::V1::Exceptions::AddressNotFoundError)
  end

  def self.cached_find(query_key)
    cache_key = query_key
    unless QueryKeyUtils.valid_hex?(query_key)
      cache_key = CkbUtils.parse_address(query_key).script.compute_hash
    end
    address =
      Rails.cache.realize([name, cache_key], race_condition_ttl: 3.seconds) do
        if QueryKeyUtils.valid_hex?(query_key)
          find_by(lock_hash: query_key)
        else
          lock_hash = CkbUtils.parse_address(query_key).script.compute_hash
          find_by(lock_hash: lock_hash)
        end
      end
    unless QueryKeyUtils.valid_hex?(query_key)
      if address.present?
        address.query_address = query_key
      else
        address = NullAddress.new(query_key)
      end
    end
    address
  end

  def cached_lock_script
    Rails.cache.realize([self.class.name, "lock_script", lock_hash], race_condition_ttl: 3.seconds) do
      lock_script.to_node_lock
    end
  end

  def flush_cache
    $redis.pipelined do
      $redis.del(*cache_keys)
    end
  end

  def cache_keys
    %W(#{self.class.name}/#{address_hash} #{self.class.name}/#{lock_hash})
  end

  def special?
    Settings.special_addresses[address_hash].present?
  end

  def cal_unclaimed_compensation
    phase1_dao_interests + unmade_dao_interests
  end

  def tx_list_cache_key
    "Address/txs/#{id}"
  end

  private

  def phase1_dao_interests
    cell_outputs.nervos_dao_withdrawing.live.find_each.reduce(0) do |memo, nervos_dao_withdrawing_cell|
      memo + CkbUtils.dao_interest(nervos_dao_withdrawing_cell)
    end
  end

  def unmade_dao_interests
    tip_dao = Block.recent.first.dao
    cell_outputs.nervos_dao_deposit.live.find_each.reduce(0) do |memo, cell_output|
      memo + DaoCompensationCalculator.new(cell_output, tip_dao).call
    end
  end
end

# == Schema Information
#
# Table name: addresses
#
#  id                     :bigint           not null, primary key
#  balance                :decimal(30, )
#  address_hash           :binary
#  cell_consumed          :decimal(30, )
#  ckb_transactions_count :decimal(30, )    default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  lock_hash              :binary
#  dao_deposit            :decimal(30, )    default(0)
#  interest               :decimal(30, )    default(0)
#  block_timestamp        :decimal(30, )
#  visible                :boolean          default(TRUE)
#  live_cells_count       :decimal(30, )    default(0)
#  mined_blocks_count     :integer          default(0)
#  average_deposit_time   :decimal(, )
#  unclaimed_compensation :decimal(30, )
#  is_depositor           :boolean          default(FALSE)
#  dao_transactions_count :decimal(30, )    default(0)
#
# Indexes
#
#  index_addresses_on_address_hash  (address_hash)
#  index_addresses_on_is_depositor  (is_depositor) WHERE (is_depositor = true)
#  index_addresses_on_lock_hash     (lock_hash) UNIQUE
#

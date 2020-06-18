FactoryBot.define do
  factory :udt do
    code_hash { "0x#{SecureRandom.hex(32)}" }
    type_hash { "0x#{SecureRandom.hex(32)}" }
    hash_type { "type" }
    args { "0x#{SecureRandom.hex(20)}" }
    udt_type { "sudt" }
    full_name { "kingdom fat coin" }
    symbol { "kfc" }
    decimal { 6 }

    trait :with_transactions do
      after(:create) do |udt, _evaluator|
        20.times do
          block = create(:block, :with_block_hash)
          transaction = create(:ckb_transaction, block: block)
          transaction1 = create(:ckb_transaction, block: block)
          create(:cell_output, block: block, ckb_transaction: transaction, generated_by: transaction, consumed_by: transaction1, type_hash: udt.type_hash, cell_type: "udt", data: "0x000050ad321ea12e0000000000000000")
        end
      end
    end
  end
end

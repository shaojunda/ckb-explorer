class StatisticInfoChart
  def initialize
    @statistic_info = StatisticInfo.new(hash_rate_statistical_interval: 100)
  end

  def id
    Time.current.to_i
  end

  def hash_rate
    to = Rails.cache.read("hash_rate_to")
    Rails.cache.fetch("hash_rate_chart_data_#{to}")
  end

  def difficulty
    max_block_number = Block.available.maximum(:number)
    last_epoch0_block_number = Block.available.where(epoch: 0).recent.first.number.to_i
    block_numbers = (last_epoch0_block_number + 1).step(max_block_number, 100).to_a
    Block.where(number: block_numbers).available.order(:number).select(:number, :difficulty).map do |block|
      { block_number: block.number.to_i, difficulty: block.difficulty.hex }
    end
  end

  def calculate_hash_rate
    max_block_number = Block.available.maximum(:number).to_i
    last_epoch0_block_number = Block.available.where(epoch: 0).recent.first.number.to_i
    from = Rails.cache.fetch("hash_rate_from") { last_epoch0_block_number }
    to = Rails.cache.fetch("hash_rate_to") { max_block_number }

    prev_cached_data = []
    if Rails.cache.read("hash_rate_chart_data_#{to}").present?
      from = to
      prev_cached_data = Rails.cache.read("hash_rate_chart_data_#{to}")
    end

    to = max_block_number
    result =
      (from + 1).step(to, 100).map do |number|
        hash_rate = statistic_info.hash_rate(number)
        { block_number: number.to_i, hash_rate: hash_rate }
      end

    Rails.cache.write("hash_rate_from", from)
    Rails.cache.write("hash_rate_to", to)
    Rails.cache.write("hash_rate_chart_data_#{to}", prev_cached_data.concat(result.compact))
  end

  private

  attr_reader :statistic_info
end
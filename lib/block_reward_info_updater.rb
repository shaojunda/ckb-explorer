require_relative "../config/environment"

loop do
  next if Sidekiq::Queue.new("block_info_updater").size > 2000

  pending_reward_blocks_ids = Block.recent.where(reward_status: "pending").limit(100).ids.map { |ids| [ids] }
  Sidekiq::Client.push_bulk("class" => "UpdateBlockRewardWorker", "args" => pending_reward_blocks_ids, "queue" => "block_info_updater") if pending_reward_blocks_ids.present?

  sleep(ENV["BLOCK_REWARD_UPDATER_LOOP_INTERVAL"].to_i)
end
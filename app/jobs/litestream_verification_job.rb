# This job will allow us to ensure that our backups are both fresh and restorable.
class LitestreamVerificationJob < ApplicationJob
  queue_as :default

  def perform
    if Feature.disabled?(:litestream_backup)
      return Rails.logger.info("Skipping litestream verification. Feature is disabled")
    end

    Litestream::Commands.databases.each do |database_hash|
      Litestream.verify!(database_hash["path"])
    end
  end
end

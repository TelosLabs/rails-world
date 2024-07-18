# This job will allow us to ensure that our backups are both fresh and restorable.
class LitestreamVerificationJob < ApplicationJob
  queue_as :default

  def perform
    Litestream::Commands.databases.each do |database_hash|
      Litestream.verify!(database_hash["path"])
    end
  end
end

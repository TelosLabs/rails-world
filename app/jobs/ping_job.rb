# Use me to make sure jobs are being processed
class PingJob < ApplicationJob
  def perform
    Rails.logger.info "Pong: #{Time.zone.now}"
  end
end

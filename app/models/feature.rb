class Feature
  ALL = [
    :only_tester_registration, # Only allow testers to register to the platform (users with an email ending in +tester)
    :session_reminders, # To enable session reminders
    :litestream_backup, # To enable Litestream backups to an S3 bucket
    :registration # Users will see a 'Coming soon' page when trying to register
  ]

  def self.enabled?(feature)
    ENV["#{feature.to_s.upcase}_ENABLED"] == "true"
  end

  def self.disabled?(feature)
    !enabled?(feature)
  end
end

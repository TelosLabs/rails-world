namespace :profiles do
  desc "Set the slug for all profiles"
  task set_slug: :environment do
    Profile.find_each(&:save)
  end
end

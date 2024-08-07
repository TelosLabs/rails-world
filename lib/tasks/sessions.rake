namespace :sessions do
  desc "update sessions slug"
  task update_slug: :environment do
    Session.find_each(&:save)
    puts "Completed. All sessions have been updated."
  end
end

return if Rails.env.production? || Rails.env.staging?

# Users
User.find_or_create_by!(email: "admin@example.com") do |user|
  user.password = "foobar2024"
  user.password_confirmation = "foobar2024"
  user.role = "admin"
end
User.find_or_create_by!(email: "dev@example.com") do |user|
  user.password = "foobar2024"
  user.password_confirmation = "foobar2024"
  user.role = "user"
end

# Conference data
Rake::Task["db:rails_world_2024_seed"].invoke(Date.current.to_s)

# Assign random tags
Tag.create!(name: "Hotwire")
Tag.create!(name: "Rails 8")
Tag.create!(name: "Kamal")
Tag.create!(name: "ActiveRecord")
Tag.create!(name: "ActionCable")

Conference.last.sessions.each do |session|
  session.tags << Tag.all.sample(rand(0..4))
end

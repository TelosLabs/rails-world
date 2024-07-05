conference = Conference.create!(name: "RailsWorld 2024")

# Users
user = User.create!(email: "dev@example.com")

# Tags
Tag.create!(name: "Hotwire")
Tag.create!(name: "Rails 8")
Tag.create!(name: "Kamal")
Tag.create!(name: "ActiveRecord")
Tag.create!(name: "ActionCable")

# Locations
bmo_atrium = Location.create!(name: "BMO Atrium", conference: conference)
terrace = Location.create!(name: "The Frances and Tim Price Terrace", conference: conference)
young_centre = Location.create!(name: "Young Centre", conference: conference)

# Speakers
10.times do |i|
  Speaker.create!(
    profile_attributes: {
      name: Faker::Name.name,
      bio: Faker::Lorem.paragraph,
      github_url: Faker::Internet.url(host: "github.com"),
      twitter_url: Faker::Internet.url(host: "twitter.com"),
      linkedin_url: Faker::Internet.url(host: "linkedin.com"),
      location: Faker::Address.city,
      is_public: [true, false].sample
    }
  )
end

# Events
conference_duration_in_days = 2
start_date = 1.week.from_now
datetime_slots = []
time_slots = [
  ["09:00", "10:00"],
  ["10:00", "11:00"],
  ["11:00", "12:30"],
  ["15:00", "16:00"],
  ["16:00", "17:00"]
]
conference_duration_in_days.times do |i|
  start_date += i.days
  time_slots.each do |start_time, end_time|
    datetime_slots << [
      DateTime.parse("#{start_date.to_date} #{start_time}"),
      DateTime.parse("#{start_date.to_date} #{end_time}")
    ]
  end
end

conference.locations.each do |location|
  speakers = case location
  when bmo_atrium
    Speaker.all.last(4)
  when terrace
    Speaker.all.first(3)
  when young_centre
    Speaker.all[3..5]
  end

  datetime_slots.each do |start_time, end_time|
    event = Event.create!(
      conference: conference,
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      starts_at: start_time,
      ends_at: end_time,
      location: location
    )
    tags_random_count = rand(1..Tag.count)
    event.tags << Tag.all.sample(tags_random_count)
    event.speakers << speakers.sample
  end
end

# Attendee's schedule
datetime_slots.each do |start_time, end_time|
  event = conference.events.where(starts_at: start_time).sample
  user.events << event
end

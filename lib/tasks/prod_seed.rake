namespace :db do
  desc "Load prod data"
  task :prod_seed, [:month_number, :day_number] => :environment do |t, args|
    seed_file = Rails.root.join("db/seeds/prod.rb")

    ENV["MONTH_NUMBER"] = args[:month_number] if args[:month_number]
    ENV["DAY_NUMBER"] = args[:day_number] if args[:day_number]

    if File.exist?(seed_file)
      puts "Seeding from #{seed_file}..."
      load seed_file
    else
      puts "Seed file #{seed_file} does not exist."
    end
  end
end

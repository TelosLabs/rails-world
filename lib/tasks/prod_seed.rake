namespace :db do
  desc "Load prod data"
  task :prod_seed, [:start_date] => :environment do |t, args|
    seed_file = Rails.root.join("db/seeds/prod.rb")

    ENV["START_DATE"] = args[:start_date] if args[:start_date]

    if File.exist?(seed_file)
      puts "Seeding from #{seed_file}..."
      load seed_file
    else
      puts "Seed file #{seed_file} does not exist."
    end
  end
end

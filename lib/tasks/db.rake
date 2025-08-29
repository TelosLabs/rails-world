namespace :db do
  desc "Loading Rails World 2025 conference data."
  task :rails_world_2025_seed, [:start_date] => :environment do |t, args|
    start_date = args[:start_date].present? ? Date.parse(args[:start_date]) : Date.new(2025, 9, 4)
    year = start_date.year
    month = start_date.month
    start_day = start_date.day
    second_day = start_date.day + 1
    image_path = "app/assets/images/speakers"

    # Create Conference
    conference = Conference.find_or_create_by!(name: "Rails World 2025")

    # Create Locations
    track_1 = conference.locations.find_or_create_by!(name: "Effectenbeurs")
    track_2 = conference.locations.find_or_create_by!(name: "Graanbeurs")

    # Create Tags
    rails_8 = Tag.find_or_create_by!(name: "Rails 8")
    multitenant = Tag.find_or_create_by!(name: "Multi-Tenant")
    sqlite = Tag.find_or_create_by!(name: "SQLite")
    databases = Tag.find_or_create_by!(name: "Databases")
    ai = Tag.find_or_create_by!(name: "Artificial Intelligence")
    mcp = Tag.find_or_create_by!(name: "Model Context Protocol")
    llm = Tag.find_or_create_by!(name: "Large Language Models")
    rails_at_scale = Tag.find_or_create_by!(name: "Rails at Scale")
    startup = Tag.find_or_create_by!(name: "Startup")
    rails_internals = Tag.find_or_create_by!(name: "Rails Internals")
    rails = Tag.find_or_create_by!(name: "Rails")
    architecture = Tag.find_or_create_by!(name: "Architecture")
    onboarding = Tag.find_or_create_by!(name: "Onboarding")
    scaling_knowledge = Tag.find_or_create_by!(name: "Scaling Knowledge")
    education = Tag.find_or_create_by!(name: "Education")
    developer_experience = Tag.find_or_create_by!(name: "Developer Experience")
    monoliths = Tag.find_or_create_by!(name: "Monoliths")
    rails_training = Tag.find_or_create_by!(name: "Rails Training")
    learning_science = Tag.find_or_create_by!(name: "Learning Science")
    active_job = Tag.find_or_create_by!(name: "Active Job")
    deployments = Tag.find_or_create_by!(name: "Deployments")
    structured_logging = Tag.find_or_create_by!(name: "Structured logging")
    data_analysis = Tag.find_or_create_by!(name: "Data Analysis")
    active_record = Tag.find_or_create_by!(name: "Active Record")
    ruby = Tag.find_or_create_by!(name: "Ruby")
    monitoring = Tag.find_or_create_by!(name: "Monitoring")
    observability = Tag.find_or_create_by!(name: "Observability")
    stability = Tag.find_or_create_by!(name: "Stability")
    crashes = Tag.find_or_create_by!(name: "Crashes")
    hotwire = Tag.find_or_create_by!(name: "Hotwire")
    ios = Tag.find_or_create_by!(name: "IOS")
    android = Tag.find_or_create_by!(name: "Android")
    mobile_development = Tag.find_or_create_by!(name: "Mobile Development")
    ai_agents = Tag.find_or_create_by!(name: "AI Agents")
    machine_learning = Tag.find_or_create_by!(name: "Machine Learning")
    performance = Tag.find_or_create_by!(name: "Performance")
    ruby_optimization = Tag.find_or_create_by!(name: "Ruby Optimization")
    memory_management = Tag.find_or_create_by!(name: "Memory Management")
    garbage_collection = Tag.find_or_create_by!(name: "Garbage Collection")
    rails_1 = Tag.find_or_create_by!(name: "Rails 1.0")
    service_workers = Tag.find_or_create_by!(name: "Service Workers")
    security = Tag.find_or_create_by!(name: "Security")
    authentication = Tag.find_or_create_by!(name: "Authentication")
    phishing = Tag.find_or_create_by!(name: "Phishing")
    turbo = Tag.find_or_create_by!(name: "Turbo")
    stimulus = Tag.find_or_create_by!(name: "Stimulus")
    react_legacy_migration = Tag.find_or_create_by!(name: "React Legacy Migration")

    # Create Speakers
    aaron_patterson = Profile.find_or_create_by!(name: "Aaron Patterson") do |profile|
      profile.job_title = "Rails Core & Senior Staff Engineer, Shopify"
      profile.bio = "Aaron is on the Rails core team, the Ruby core team, and is a Senior Staff Engineer working at Shopify. In his free time, he enjoys cooking, playing with cats, and writing weird software."
      profile.github_url = "https://github.com/tenderlove"
      profile.linkedin_url = "https://www.linkedin.com/in/tenderlove/"
      profile.twitter_url = "https://twitter.com/tenderlove"
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Aaron_Patterson.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    adrianna_chang = Profile.find_or_create_by!(name: "Adrianna Chang") do |profile|
      profile.job_title = "Staff Software Engineer, Shopify"
      profile.bio = "Adrianna is a senior software engineer on the Rails Infra team at Shopify. She's a member of the Rails Issues team and a WNB.rb community leader. She's passionate about Ruby, mentorship, and open source. In her spare time, you'll find her doing something outdoors or hanging with her rottie, Jasper."
      profile.github_url = "https://github.com/adrianna-chang-shopify"
      profile.linkedin_url = "https://ca.linkedin.com/in/adrianna-chang-42464796"
      profile.twitter_url = "https://twitter.com/adriannakchang"
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Adrianna_Chang.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    austin_story = Profile.find_or_create_by!(name: "Austin Story") do |profile|
      profile.job_title = "Senior Engineering Director, Product Platform"
      profile.bio = "Hi, I'm Austin. I enjoy building and scaling teams and products using Rails at Doximity. I am currently an Engineering Director of the Product Platform at Doximity and work with several teams responsible for core shared architectural concerns."
      profile.github_url = "https://www.github.com/austio"
      profile.linkedin_url = "https://www.linkedin.com/in/rubyprogramming/"
      profile.twitter_url = "https://twitter.com/austio36"
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Austin_Story.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    chris_oliver = Profile.find_or_create_by!(name: "Chris Oliver") do |profile|
      profile.job_title = "Founder"
      profile.bio = "Chris is a Rails Luminary, entrepreneur and content creator. He makes weekly Ruby on Rails screencasts at GoRails.com, a Ruby on Rails SaaS template called Jumpstart Pro and a hosting service called Hatchbox.io."
      profile.github_url = "https://www.github.com/excid3"
      profile.linkedin_url = "https://linkedin.com/in/excid3"
      profile.twitter_url = "https://twitter.com/excid3"
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Chris_Oliver.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    david_heinemeier_hansson = Profile.find_or_create_by!(name: "David Heinemeier Hansson") do |profile|
      profile.job_title = "Rails Core, CTO, 37signals"
      profile.bio = "Creator of Ruby on Rails."
      profile.github_url = "https://github.com/dhh"
      profile.linkedin_url = "https://www.linkedin.com/in/david-heinemeier-hansson-374b18221/"
      profile.twitter_url = "https://twitter.com/dhh"
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-David.jpeg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    donal_mcbreen = Profile.find_or_create_by!(name: "Donal McBreen") do |profile|
      profile.job_title = "Lead Programmer (Security, Infrastructure and Performance)"
      profile.bio = "Donal has been a web programmer for over 25 years, working with Rails for the last 10 years. He works in the Security, Infrastructure and Performance (SIP) team at 37signals where he maintains the open source gems Solid Cache and Kamal."
      profile.github_url = "https://github.com/djmb"
      profile.linkedin_url = "https://www.linkedin.com/in/donal-mcbreen-a8227a52/"
      profile.twitter_url = ""
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Donal_McBreen.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    hartley_mcguire = Profile.find_or_create_by!(name: "Hartley McGuire") do |profile|
      profile.job_title = "Rails Issues Team & Senior Developer"
      profile.bio = "Hartley McGuire is a member of the Rails Issues Team and a Senior Developer at Shopify. Outside of work he enjoys contributing to open source projects, building out his homelab, and playing volleyball."
      profile.github_url = ""
      profile.linkedin_url = ""
      profile.twitter_url = ""
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Hartley_McGuire.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    jack_sharkey = Profile.find_or_create_by!(name: "Jack Sharkey") do |profile|
      profile.job_title = "CTO / Co-Founder"
      profile.bio = "Jack Sharkey is the founder and CTO of Whop, a Rails-powered startup that scaled from $0 to $1B+ in four years. He’s passionate about developer experience, scaling Rails, and helping the next generation of founders and engineers succeed."
      profile.github_url = "https://github.com/sharkey11"
      profile.linkedin_url = "https://www.linkedin.com/in/sharkeyjack/"
      profile.twitter_url = "http://x.com/jacksharkey11"
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Jack_Sharkey.png").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    jason_meller = Profile.find_or_create_by!(name: "Jason Meller") do |profile|
      profile.job_title = "VP, Engineering"
      profile.bio = "Jason Meller is VP of Engineering at 1Password, the author of the Honest Security manifesto (honest.security), and the former CEO & founder of Kolide. Jason has spent his 15 year career building Rails apps for IT/Security professionals, with the goal of making the field accessible to newcomers."
      profile.github_url = ""
      profile.linkedin_url = "https://www.linkedin.com/in/jason-meller-04498230/"
      profile.twitter_url = "https://twitter.com/jmeller"
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Jason_Meller.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    joe_masilotti = Profile.find_or_create_by!(name: "Joe Masilotti") do |profile|
      profile.job_title = "The Hotwire Native guy"
      profile.bio = "Joe is on a mission to make mobile app development easier for Rails developers. He's been working with Hotwire Native since 2016, is a maintainer of the library, and the author of 'Hotwire Native for Rails Developers'."
      profile.github_url = "https://www.github.com/joemasilotti"
      profile.linkedin_url = "https://www.linkedin.com/in/joemasilotti/"
      profile.twitter_url = "https://x.com/joemasilotti"
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Joe_Masilotti.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    katarina_rossi = Profile.find_or_create_by!(name: "Katarina Rossi") do |profile|
      profile.job_title = "Staff Software Engineer"
      profile.bio = "Katarina is a Staff Engineer at Procore, where she works on the Directory - a key piece of the plumbing of the giant Rails monolith. She grew up around real trenches (her family did underground utilities) so it makes sense she’d end up in the digital ones, too."
      profile.github_url = "https://github.com/dischorde"
      profile.linkedin_url = "https://www.linkedin.com/in/katarinarossi/"
      profile.twitter_url = ""
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Katarina_Rossi.png").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    kevin_mcconnell = Profile.find_or_create_by!(name: "Kevin McConnell") do |profile|
      profile.job_title = "Lead Programmer"
      profile.bio = "Kevin is a programmer at 37signals, where he writes a lot of Ruby, and sometimes a bit of Go. When he's not doing that, he enjoys making electronic music and hiking."
      profile.github_url = ""
      profile.linkedin_url = ""
      profile.twitter_url = ""
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Kevin_McConnell.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    kinsey_durham_grace = Profile.find_or_create_by!(name: "Kinsey Durham Grace") do |profile|
      profile.job_title = "Software Engineer on Copilot"
      profile.bio = "Kinsey Durham Grace is an engineer on GitHub Copilot and VP of the Ruby Central board. She leads GitHub’s Adacats, supporting women and non-binary folks in tech. Based in Colorado, she enjoys mountain adventures with her two young kids and adventurous pup."
      profile.github_url = "https://www.github.com/kinseydurhamgrace"
      profile.linkedin_url = "https://www.linkedin.com/in/kinseyanndurham/"
      profile.twitter_url = "https://twitter.com/KinseyAnnDurham"
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Kinsey_Durham_Grace.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    masafumi_okura = Profile.find_or_create_by!(name: "Masafumi Okura") do |profile|
      profile.job_title = "Freelance Ruby/Rails developer"
      profile.bio = "Masafumi has been a Ruby programmer for 10 years. He's the chief organizer of Kaigi on Rails, a tech conference focusing on Rails. He also organizes a few Ruby meetups in Japan. He maintains some gems including Alba, a JSON serializer for Ruby."
      profile.github_url = "https://github.com/okuramasafumi"
      profile.linkedin_url = "https://www.linkedin.com/in/masafumi-okura-82651128/"
      profile.twitter_url = "https://twitter.com/okuramasafumi"
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Masafumi_Okura.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    mike_dalessio = Profile.find_or_create_by!(name: "Mike Dalessio") do |profile|
      profile.job_title = "Staff Engineer"
      profile.bio = "Mike has been contributing to Ruby open source since 2006, and maintains some commonly-used gems. He's currently at 37signals on the SIP team, and previously led Shopify's Ruby and Rails Infrastructure team. He likes coffee, intimate chats, and long walks, and has been known to combine all three."
      profile.github_url = "https://github.com/minuteman3/"
      profile.linkedin_url = "https://www.linkedin.com/in/milesmcguire"
      profile.twitter_url = ""
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Mike_Dalessio.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    miles_mcguire = Profile.find_or_create_by!(name: "Miles McGuire") do |profile|
      profile.job_title = "Staff Engineer, Intercom"
      profile.bio = "Miles has spent 8 years at Intercom working on datastore performance, scalability, and availability from the application layer all the way down."
      profile.github_url = "https://github.com/minuteman3"
      profile.linkedin_url = "https://www.linkedin.com/in/milesmcguire/"
      profile.twitter_url = ""
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Miles_McGuire.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    pawel_strzalkowski = Profile.find_or_create_by!(name: "Pawel Strzalkowski") do |profile|
      profile.job_title = "CTO"
      profile.bio = "CTO, consultant and full-stack developer since the 90s. Author of many articles showing a creative approach to using Rails. Currently excited about AI's potential and cross-tech discoveries. Frequent speaker at conferences/meetups and a big supporter of the European Ruby scene. Builds games for fun."
      profile.github_url = "https://github.com/pstrzalk"
      profile.linkedin_url = "https://www.linkedin.com/in/pawel-strzalkowski/"
      profile.twitter_url = "https://x.com/realPawelS"
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Pawel_Strzalkowski.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    peter_zhu = Profile.find_or_create_by!(name: "Peter Zhu") do |profile|
      profile.job_title = "Ruby Core committer, Staff Developer"
      profile.bio = "Peter is a Ruby core committer and Senior Developer at Shopify. He works on improving the performance of Ruby and is currently working on Modular GC and the MMTk integration. He is the co-author of Variable Width Allocation in Ruby, which improves Ruby's performance by optimizing the memory layout."
      profile.github_url = "https://github.com/peterzhu2118"
      profile.linkedin_url = "https://linkedin.com/in/peterzhu2118"
      profile.twitter_url = "https://twitter.com/peterzhu2118"
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Peter-Zhu.png").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    radan_skoric = Profile.find_or_create_by!(name: "Radan Skoric") do |profile|
      profile.job_title = "Lead Software Engineer"
      profile.bio = "Full stack developer with over 17 years of professional experience solving problems with Software, mainly with Ruby and Rails. Author of 'Master Hotwire' e-book. I split my time between coding the backend of (mostly complex) applications and leading and increasing efficiency of a team of developers. I am bullish on Hotwire approach."
      profile.github_url = "https://github.com/radanskoric/"
      profile.linkedin_url = "https://www.linkedin.com/in/radanskoric/"
      profile.twitter_url = "https://x.com/RadanSkoric"
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Radan_Skoric.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    rosa_gutierrez = Profile.find_or_create_by!(name: "Rosa Gutierrez") do |profile|
      profile.job_title = "Principal programmer, 37signals"
      profile.bio = "Loves cities, mathematics, theoretical computer science, learning languages for humans and computers, puzzles & bicycles. Human to Mochi."
      profile.github_url = "https://github.com/rosa"
      profile.linkedin_url = "https://www.linkedin.com/in/rosagutierrezescudero/"
      profile.twitter_url = "https://twitter.com/rosapolis"
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Rosa_Gutierrez.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    snehal_ahire = Profile.find_or_create_by!(name: "Snehal Ahire") do |profile|
      profile.job_title = "Lead Software Engineer"
      profile.bio = "Snehal is lead engineer who loves solving backend problems. She has scaled, refactored old legacy system, with a focus on performance and mentoring. When she's not deep in code, you’ll find her painting, cooking something new, or happily lost in her garden balancing bugs with blooms."
      profile.github_url = "http://github.com/snehalahire"
      profile.linkedin_url = "https://www.linkedin.com/in/snehal-ahire27/"
      profile.twitter_url = ""
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Snehal_Ahire.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    andrew_mcnamara = Profile.find_or_create_by!(name: "Andrew McNamara") do |profile|
      profile.job_title = "Director Applied ML"
      profile.bio = ""
      profile.github_url = ""
      profile.linkedin_url = ""
      profile.twitter_url = ""
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-A_Mcnamara.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    hiroshi_shibata = Profile.find_or_create_by!(name: "Hiroshi Shibata") do |profile|
      profile.job_title = "Ruby Maintainer"
      profile.bio = "OSS programmer, Ruby committer, maintainer of many OSS such as Ruby, rubygems, rake, ruby-build and administrator of ruby-lang.org. Hiroshi maintains the infrastructure that supports the development of the Ruby programming language. He is working in public relations of technology for ANDPAD Inc. and is a full time OSS developer for the Ruby programming language."
      profile.github_url = "https://github.com/hsbt"
      profile.linkedin_url = "https://www.linkedin.com/in/hiroshi-shibata-04264122/"
      profile.twitter_url = ""
      profile.is_public = true
      profile.image = Rails.root.join("#{image_path}/RW-Hiroshi_Shibata.jpeg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    charles_lee = Profile.find_or_create_by!(name: "Charlie Lee") do |profile|
      profile.job_title = "Staff Engineer"
      profile.bio = "Charlie is a Staff Software Engineer on the Assistants team at Shopify. He's been working on empowering merchants with chat including Shopify Inbox and other chatbots (before LLMs!). Outside of work, he's tinkering with his homelab and playing tennis."
      profile.github_url = ""
      profile.linkedin_url = "https://www.linkedin.com/in/charleschanlee/"
      profile.twitter_url = ""
      profile.image = Rails.root.join("#{image_path}/RW-C-Lee.jpeg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    marco_roth = Profile.find_or_create_by!(name: "Marco Roth") do |profile|
      profile.job_title = "Independent Consultant & OS Contributor"
      profile.bio = "Marco is a passionate full-stack Ruby on Rails developer and a dedicated open-source contributor. As a member of the Hotwire and StimulusReflex contributors teams he has been pushing the limits of real-time server-rendered applications using the HTML-over-the-wire (Hotwire) approach. He has actively open-sourced, maintained, and contributed to several key libraries within the Hotwire and Ruby on Rails ecosystem."
      profile.github_url = "https://github.com/marcoroth"
      profile.linkedin_url = "https://www.linkedin.com/in/marco-roth/"
      profile.twitter_url = "https://twitter.com/marcoroth_"
      profile.image = Rails.root.join("#{image_path}/RW-M-Roth.jpeg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    jean_boussier = Profile.find_or_create_by!(name: "Jean Boussier") do |profile|
      profile.job_title = "Senior Staff Engineer"
      profile.bio = "Rails core, Ruby committer, Senior Staff Engineer on Shopify's Ruby and Rails infrastructure team."
      profile.github_url = "https://github.com/byroot"
      profile.linkedin_url = ""
      profile.twitter_url = "https://x.com/_byroot"
      profile.image = Rails.root.join("#{image_path}/RW-J_Boussier.jpeg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    # Create Sessions
    # Day 1 - Track 1
    Session.find_or_create_by!(
      conference: conference,
      title: "Opening Keynote",
      starts_at: Time.zone.local(year, month, start_day, 10, 0)
    ) do |session|
      session.description = "DHH will kick off the third edition of Rails World in Amsterdam with an Opening Keynote highlighting what is new in Rails today, and where the framework is headed tomorrow."
      session.ends_at = Time.zone.local(year, month, start_day, 11, 0)
      session.location = track_1
      session.speakers = [david_heinemeier_hansson]
      session.tags = [rails_8]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Multi-Tenant Rails: Everybody Gets a Database!",
      starts_at: Time.zone.local(year, month, start_day, 11, 15)
    ) do |session|
      session.description = "As Rails’s SQLite support has improved, it's finally possible to have truly multi-tenant Rails applications - isolated data for each account! - without sacrificing performance or ease of use. This talk describes a novel, production-vetted approach to isolating tenant data everywhere in Rails: the database, fragment caches, background jobs, Active Storage, Turbo Stream broadcasts, Action Mailer, and even the testing framework.

You’ll learn how to build a new multi-tenant app or migrate an existing one. You'll learn the technical details of how Rails can support multiple tenants and strict data isolation. You'll see a live demonstration of a multi-tenant app. And you'll learn why a deployment topology like this might make sense for you, and how it scales up and out."
      session.ends_at = Time.zone.local(year, month, start_day, 11, 45)
      session.location = track_1
      session.speakers = [mike_dalessio]
      session.tags = [multitenant, sqlite, databases]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "SQLite Replication with Beamer",
      starts_at: Time.zone.local(year, month, start_day, 13, 0)
    ) do |session|
      session.description = "SQLite is an increasingly popular choice for powering Rails applications. It's fast, simple to use, and has an impressive feature set. But without a conventional database server, scaling beyond a single application server can be challenging.

Beamer is a lightweight replication tool for SQLite, designed to make it easy to add read-only replicas to your writable databases. In this talk, we'll cover how Beamer works and how you can use it to build multi-server, geographically distributed SQLite-based Rails applications."
      session.ends_at = Time.zone.local(year, month, start_day, 13, 30)
      session.location = track_1
      session.speakers = [kevin_mcconnell]
      session.tags = [sqlite, databases]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Beyond the Prompt: Building Real-World LLM Features in Rails",
      starts_at: Time.zone.local(year, month, start_day, 13, 45)
    ) do |session|
      session.description = "Prompting an LLM is easy. Building a Rails app that reliably integrates one? That’s a different story. This talk goes beyond prompt hacking to explore what it takes to bring LLM-powered features into real-world Rails apps—with real users, latency constraints, and production consequences. We’ll cover architectural patterns like model orchestration, prompt versioning, and skill/tool design, all tailored to the Rails ecosystem. You’ll learn how to connect your LLM to internal APIs, business logic, and background jobs, while keeping everything observable, testable, and maintainable. Whether you're adding a smart assistant or orchestrating agents, you’ll leave with practical Rails-specific strategies and patterns to build it right."
      session.ends_at = Time.zone.local(year, month, start_day, 14, 15)
      session.location = track_1
      session.speakers = [kinsey_durham_grace]
      session.tags = [ai, mcp, llm]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Taming the Beast: Safely Managing Database Operations in Rails in a Team of 100s",
      starts_at: Time.zone.local(year, month, start_day, 14, 45)
    ) do |session|
      session.description = "Intercom leverages Rails to empower hundreds of engineers to move fast and make the changes they need in production without a lengthy centralized review process. But allowing arbitrary migrations to run across hundreds of tables and hundreds of terabytes of data in MySQL comes with inherent risks. In this session, we’ll look at where we came from, what changes we've made to reduce risk and enable people to move fast while safely leveraging Rails’ power, and where we're going in the future."
      session.ends_at = Time.zone.local(year, month, start_day, 15, 15)
      session.location = track_1
      session.speakers = [miles_mcguire]
      session.tags = [databases, rails_at_scale, performance]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "The $1B Rails Startup: Scaling from 0 to Unicorn in Four Years",
      starts_at: Time.zone.local(year, month, start_day, 15, 45)
    ) do |session|
      session.description = "We started when Rails was “dead.” Everyone said it wouldn’t scale, wasn’t fast enough, and that no one used it anymore. Four years later, we’ve processed $1B+, handle 150k RPM, and run a feature-complete marketplace with real-time chat, notifications, payments, and live streaming - all on a Rails monolith with just 15 engineers.

This talk breaks down how Rails gave us a competitive edge, the technical and hiring challenges we faced, and what Rails needs to improve to stay the best framework for startups."
      session.ends_at = Time.zone.local(year, month, start_day, 16, 15)
      session.location = track_1
      session.speakers = [jack_sharkey]
      session.tags = [rails_at_scale, startup]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Hotwire Native: A Rails Developer’s Secret Tool to Building Mobile Apps",
      starts_at: Time.zone.local(year, month, start_day, 16, 30)
    ) do |session|
      session.description = "Building native mobile apps is time-consuming and expensive. Each screen must be built three times: once for web, again for iOS, and a third time for Android.

But with Hotwire Native, you only need to build your screens once, in HTML and CSS, and then reuse them across all three platforms. If you already have a Hotwire-enabled Rails app, you can use the screens you've already built!

And you don't need to be an expert in Swift or Kotlin. A thin wrapper for each platform enables continuous updates by only making changes to your Rails codebase. Deploy your code, and all three platforms get your changes immediately.

Join me as I build iOS and Android apps from scratch, live. Learn the essentials, practical tips, and common pitfalls I’ve picked up since working with Hotwire Native since 2016."
      session.ends_at = Time.zone.local(year, month, start_day, 17, 30)
      session.location = track_1
      session.speakers = [joe_masilotti]
      session.tags = [hotwire, ios, android, mobile_development]
    end

    # Day 1 - Track 2
    Session.find_or_create_by!(
      conference: conference,
      title: "Startup Speed, Enterprise Scale: Rails Powers 3k Events/Sec Throughput",
      starts_at: Time.zone.local(year, month, start_day, 11, 15)
    ) do |session|
      session.description = "Ditch vendor lock-in! Doximity, like many mid-sized innovators, needed rapid iteration and cost-effective scale. We replaced a slow, expensive analytics vendor with a custom Rails pipeline, achieving 3k events/second scale with Rails. Learn how Rails' integrated power—Kafka (Karafka), Action Cable for real-time debugging, and optimized request handling—enabled our small team to build a high-throughput system, slashing latency from hours to seconds and saving hundreds of thousands of dollars per year. Learn how Rails’ conventions and ecosystem offer startup agility with enterprise-level performance, proving it’s the ideal toolkit for rapid growth and reclaiming control. See how your team can leverage Rails to conquer data challenges and achieve massive ROI."
      session.ends_at = Time.zone.local(year, month, start_day, 11, 45)
      session.location = track_2
      session.speakers = [austin_story]
      session.tags = [rails, architecture]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Teaching Rails with the Real Thing: Onboarding Engineers into a (Massive) Monolith",
      starts_at: Time.zone.local(year, month, start_day, 13, 0)
    ) do |session|
      session.description = "At Procore, our Rails monolith is massive - among the largest in the world - and intimidating to newcomers. I designed and taught a course that helped over 900 engineers of varying skill levels stop fearing it by teaching Rails and our monolith at the same time. Rather than using generic tutorials, we grounded everything in the actual product they’d be working on - layering Rails fundamentals with the domain-specific knowledge they really needed. In this talk, I’ll share how learning science, product context, and deep app knowledge came together to make our course work—and how you can adapt it for your team."
      session.ends_at = Time.zone.local(year, month, start_day, 13, 30)
      session.location = track_2
      session.speakers = [katarina_rossi]
      session.tags = [onboarding, scaling_knowledge, education, developer_experience, monoliths, rails_training, learning_science]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Resumable Jobs with Active Job Continuations",
      starts_at: Time.zone.local(year, month, start_day, 13, 45)
    ) do |session|
      session.description = "Long-running jobs can cause problems. They can delay deployments and leave old versions of your code running longer than expected. Interrupting them can leave data in an inconsistent state or cause redundant rework.

Active Job Continuations let you define multi-step workflows or checkpoint iterations to track your progress, and they’re easy to integrate with your existing jobs. From there, they handle interrupting and resuming jobs across application restarts.

We built Active Job Continuations at 37signals to make Basecamp's jobs container-friendly for deploying with Kamal. Come to this talk to learn more about how it works."
      session.ends_at = Time.zone.local(year, month, start_day, 14, 15)
      session.location = track_2
      session.speakers = [donal_mcbreen]
      session.tags = [rails_8, active_job, deployments]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "From Chaos to Clarity: Structured Event Reporting in Rails",
      starts_at: Time.zone.local(year, month, start_day, 14, 45)
    ) do |session|
      session.description = "Events in Rails applications are like the heartbeat of your code - whether it’s a log, a telemetry signal, or a business event, they tell us when something interesting is happening. To truly harness he power of these events for observability and data analysis, we need high-quality, contextualized data. The human-readable lines that Rails.logger provides is great for manual inspection but falls short in production and analytics contexts. At Shopify, we recognized the need for a unified approach to events. After years of managing various in-house solutions for structured logging, we built support for structured events into the Rails framework itself. This talk will unveil the Structured Event Reporter, Rails’ new approach to structured events, and showcase how we’re using it to power events in our monolith."
      session.ends_at = Time.zone.local(year, month, start_day, 15, 15)
      session.location = track_2
      session.speakers = [adrianna_chang]
      session.tags = [structured_logging, data_analysis, rails_internals]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Active Record 8: Resilient by Default",
      starts_at: Time.zone.local(year, month, start_day, 15, 45)
    ) do |session|
      session.description = "Databases crash, connections drop, and queries timeout at the worst possible moments. Rather than writing custom rescue code everywhere, Rails is revolutionizing how Active Record handles these inevitable hiccups.

This technical deep dive explores key improvements in connection management, error handling, and recovery strategies introduced in Rails 7 and optimized in Rails 8. You'll learn how Active Record intelligently manages connection pools and retries failed queries.

Whether you're running a massive production app or building a new side project, you'll walk away knowing how to leverage these features to build applications that bend instead of break when database chaos strikes."
      session.ends_at = Time.zone.local(year, month, start_day, 16, 15)
      session.location = track_2
      session.speakers = [hartley_mcguire]
      session.tags = [active_record]
    end

    # Day 2 - Track 1
    Session.find_or_create_by!(
      conference: conference,
      title: "Ruby & Rails - a Chat between Maintainers",
      starts_at: Time.zone.local(year, month, second_day, 10, 0)
    ) do |session|
      session.description = "Join us for a special panel focused on the developer experience in the Ruby and Rails ecosystem.

Aaron Patterson and Jean Boussier from the Rails Core team will be joined by special guest Hiroshi Shibata (hsbt), Ruby committer, and a maintainer of RubyGems, Rake, ruby-build, and an administrator of ruby-lang.org."
      session.ends_at = Time.zone.local(year, month, second_day, 11, 0)
      session.location = track_1
      session.speakers = [hiroshi_shibata, jean_boussier, aaron_patterson]
      session.tags = [rails, ruby]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Ruby Stability at Scale",
      starts_at: Time.zone.local(year, month, second_day, 11, 15)
    ) do |session|
      session.description = "There are many talks, articles, and tutorials on how to monitor your Rails app for stability. These assume the source of the bug comes from your application code, from Rails itself, or from a gem. But what if the source of instability comes from Ruby or a native gem? If Ruby crashes, do you have any monitoring or ways to debug it?

In this talk, we'll look at how we deal with Ruby crashes in the Shopify monolith, the world's largest Ruby on Rails application, and how you can use some of our techniques. We'll cover topics such as how we monitor crashes, capture core dumps for debugging, prevent crashes, and minimize the impact of crashes on production."
      session.ends_at = Time.zone.local(year, month, second_day, 11, 45)
      session.location = track_1
      session.speakers = [peter_zhu]
      session.tags = [ruby, monitoring, observability, stability, crashes]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Make Rails AI-Ready by Design with the Model Context Protocol",
      starts_at: Time.zone.local(year, month, second_day, 13, 0)
    ) do |session|
      session.description = "Remember the joy of Rails scaffold creating web interfaces in DHH’s demos? Let’s make it just as simple for AI integrations!

Imagine Rails scaffolding not just views for humans, but a parallel, AI interaction layer - out of the box!

How? By embracing convention over configuration with the Model Context Protocol (MCP), the emerging standard (backed by Google & OpenAI) for AI-app interactions.
Example: Scaffold a ReservationsController and instantly let an AI agent book a room via MCP - just like agents may use it with GitHub or JIRA today.

I’ll show:
- A full-stack AI-ready app scaffolded live
- An AI agent using it
- How backend, frontend, and AI layers cooperate
- How to make your app speak AI natively

Ultimately, this talk shows Rails’ competitive advantage for the AI era."
      session.ends_at = Time.zone.local(year, month, second_day, 13, 30)
      session.location = track_1
      session.speakers = [pawel_strzalkowski]
      session.tags = [rails, ai, llm, mcp]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Beyond the Basics: Advanced Rails Techniques",
      starts_at: Time.zone.local(year, month, second_day, 13, 45)
    ) do |session|
      session.description = "This talk showcases ways to take a traditional Rails app and shape it around your product domain—while also using Rails tools in ways you might not have considered.
      Topics include:
      - Creating your own app/ folders for domain concepts
      - Creating your own generators
      - Organizing features by modules and concerns (e.g., the User model may have teams, billing, etc., organized under app/models/user/)
      - Adding domainwording and class methods, like allow_unauthenticated_access or rate_limit"
      session.ends_at = Time.zone.local(year, month, second_day, 14, 15)
      session.location = track_1
      session.speakers = [chris_oliver]
      session.tags = [rails]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Introducing ReActionView: An ActionView-Compatible ERB Engine",
      starts_at: Time.zone.local(year, month, second_day, 14, 45)
    ) do |session|
      session.description = "This talk is the conclusion of a journey I’ve been sharing throughout 2025. At RubyKaigi, I introduced Herb: a new HTML-aware ERB parser and tooling ecosystem. At RailsConf, I released developer tools built on Herb, including a formatter, linter, and language server, alongside a vision for modernizing and improving the Rails view layer.

At Rails World, I’ll debut ReActionView: a new ERB engine built on Herb, fully compatible with .html.erb but with HTML validation, better error feedback, reactive updates, and built-in tooling.

This will be the first public release, exclusive to Rails World, tying together everything from the past talks and even bringing exclusive updates to tools I first showed at Rails World 2023."
      session.ends_at = Time.zone.local(year, month, second_day, 15, 15)
      session.location = track_1
      session.speakers = [marco_roth]
      session.tags = [rails]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "LLM Evaluations & Reinforcement Learning for Shopify Sidekick on Rails",
      starts_at: Time.zone.local(year, month, second_day, 15, 45)
    ) do |session|
      session.description = "This talk explores building production LLM systems through Shopify Sidekick's Rails architecture, covering orchestration patterns and tool integration strategies. We'll establish statistically rigorous LLM-based evaluation frameworks that move beyond subjective \"vibe testing.\" Finally, we'll demonstrate how robust evaluation systems become critical infrastructure for reinforcement learning pipelines, while exploring how RL can learn to hack evaluations and strategies to mitigate this."
      session.ends_at = Time.zone.local(year, month, second_day, 16, 15)
      session.location = track_1
      session.speakers = [andrew_mcnamara, charles_lee]
      session.tags = [ai_agents, machine_learning, llm, ai]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Closing Keynote",
      starts_at: Time.zone.local(year, month, second_day, 16, 30)
    ) do |session|
      session.description = "We actually never know with Aaron. We'll find out what this session is about when you do."
      session.ends_at = Time.zone.local(year, month, second_day, 17, 30)
      session.location = track_1
      session.speakers = [aaron_patterson]
      session.tags = [rails_internals]
    end

    # Day 2 - Track 2
    Session.find_or_create_by!(
      conference: conference,
      title: "Rails Under a Microscope: Diagnosing Slowness at the Byte Level",
      starts_at: Time.zone.local(year, month, second_day, 11, 15)
    ) do |session|
      session.description = "We realized our legacy code didn’t need a rewrite, it needed a performance plan.

This talk shares how we tackled real production issues like memory bloat, slow queries, and Sidekiq queues piling up under load, where simple fixes like batching jobs or tweaking retries didn’t help much.

We thought Active Record was the bottleneck, but fixing it only scratched the surface. We optimised query access patterns, chose more efficient data structures, restructured background jobs, and introduced smarter database caching and indexing strategies.

I’ll share how we analysed query plans, fine-tuned database performance, and replaced slow, fragile logic with leaner, more explicit code paths that scaled better and failed less while Rails stayed right at the center of it all."
      session.ends_at = Time.zone.local(year, month, second_day, 11, 45)
      session.location = track_2
      session.speakers = [snehal_ahire]
      session.tags = [performance, ruby, ruby_optimization, memory_management, garbage_collection]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Reading Rails 1.0 Source Code",
      starts_at: Time.zone.local(year, month, second_day, 13, 0)
    ) do |session|
      session.description = "Rails is great. In fact, Rails has been great since the very beginning. However, in terms of technical details, Rails 1.0 was very different from Rails 8. Lots of things have changed, many frameworks have been introduced and overall quality has been polished.
This leads to an interesting question. What makes Rails Rails itself? What core parts of Rails still remain after 20 years?
In this anthropological talk, we dive into the source code of Rails 1.0 and explore internals."
      session.ends_at = Time.zone.local(year, month, second_day, 13, 30)
      session.location = track_2
      session.speakers = [masafumi_okura]
      session.tags = [rails_1]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Coming Soon: Offline Mode to Hotwire with Service Workers",
      starts_at: Time.zone.local(year, month, second_day, 13, 45)
    ) do |session|
      session.description = "Rosa is trying out a new methodology called Conference Driven Development™, so she's actually hard at work on building what she will discuss in her talk at Rails World. So for now, this abstract is To Be Determined. Wish her luck!"
      session.ends_at = Time.zone.local(year, month, second_day, 14, 15)
      session.location = track_2
      session.speakers = [rosa_gutierrez]
      session.tags = [hotwire, service_workers]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Passkeys Have Problems, but So Will You If You Ignore Them",
      starts_at: Time.zone.local(year, month, second_day, 14, 45)
    ) do |session|
      session.description = "Back in 2024, many of us in the Rails community dismissed passkeys as hype rather than a real password replacement. But now we're facing a serious problem - a newer and more sophisticated attack called Real-Time Phishing is gaining popularity and effortlessly defeating nearly all popular 2FA methods, except one: passkeys. Even security experts are getting fooled, and AI makes these attacks frighteningly scalable. In this session, I'll demo exactly how attackers execute real-time phishing live. Then we'll turn the tables: I'll guide you step-by-step through adding secure, user-friendly passkey authentication as an MFA option to your Rails 8 apps. Come on, Rails! Let's give passkeys one more chance."
      session.ends_at = Time.zone.local(year, month, second_day, 15, 15)
      session.location = track_2
      session.speakers = [jason_meller]
      session.tags = [security, authentication, phishing]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Lessons from Migrating a Legacy Frontend to Hotwire",
      starts_at: Time.zone.local(year, month, second_day, 15, 45)
    ) do |session|
      session.description = "Is Hotwire just for `rails new` scenarios and not worth it for mature applications? Absolutely not.

I share my learnings from leading a migration of Halalbooking.com, a large hotel booking website, from a mix of technologies centered on React to Hotwire.

Even though we couldn't enable Turbo Drive, we got a huge DX and performance boost from using other parts of Hotwire, making the migration more than worth it.

I’ll share specific examples and lessons learned along the way. You'll leave optimistic about introducing Hotwire to a mature codebase.

As a bonus, you’ll see:
- When it's beneficial
- How fast it pays back
- How to introduce it gradually
- Two concrete examples of complex Hotwire UIs"
      session.ends_at = Time.zone.local(year, month, second_day, 16, 15)
      session.location = track_2
      session.speakers = [radan_skoric]
      session.tags = [hotwire, turbo, stimulus, react_legacy_migration]
    end
  end
end

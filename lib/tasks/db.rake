namespace :db do
  desc "Loading Rails World 2024 conference data."
  task :rails_world_2024_seed, [:start_date] => :environment do |t, args|
    start_date = args[:start_date].present? ? Date.parse(args[:start_date]) : Date.new(2024, 9, 26)
    month = start_date.month
    start_day = start_date.day
    second_day = start_day + 1
    image_path = "app/assets/images/speakers"

    # Create Conference
    conference = Conference.find_or_create_by!(name: "Rails World 2024")

    # Create Locations
    track_1 = conference.locations.find_or_create_by!(name: "Track 1")
    track_2 = conference.locations.find_or_create_by!(name: "Track 2")
    lightning_track = conference.locations.find_or_create_by!(name: "Lightning Track")
    sponsor_garden = conference.locations.find_or_create_by!(name: "Sponsor Garden")
    sponsor_lounge = conference.locations.find_or_create_by!(name: "Sponsor Lounge")
    break_location = conference.locations.find_or_create_by!(name: "Sponsor Garden, Shopify Lounge, Lightning Track, Kilns, Pavilions")
    tbd_location = conference.locations.find_or_create_by!(name: "TBD (will be shared with registered attendees)")
    shopify_port = conference.locations.find_or_create_by!(name: "Shopify Port")

    # Create Tags
    # No tags for now

    # Create Speakers
    matz_speaker = Profile.find_or_create_by!(name: "Yukihiro \"Matz\" Matsumoto") do |profile|
      profile.job_title = "Creator of Ruby"
      profile.bio = "Matz is the creator and chief designer of the Ruby programming language."
      profile.github_url = "https://github.com/matz"
      profile.linkedin_url = ""
      profile.twitter_url = "https://x.com/yukihiro_matz"
      profile.image = Rails.root.join("#{image_path}/m-matsumoto.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    aaron_patterson_speaker = Profile.find_or_create_by!(name: "Aaron Patterson") do |profile|
      profile.job_title = "Rails Core & Senior Staff Engineer, Shopify"
      profile.bio = "Aaron is on the Rails core team, the Ruby core team, and is a Senior Staff Engineer working at Shopify. In his free time, he enjoys cooking, playing with cats, and writing weird software."
      profile.github_url = "https://github.com/tenderlove"
      profile.linkedin_url = "https://www.linkedin.com/in/tenderlove/"
      profile.twitter_url = "https://twitter.com/tenderlove"
      profile.image = Rails.root.join("#{image_path}/a-patterson.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    david_heinemeier_hansson_speaker = Profile.find_or_create_by!(name: "David Heinemeier Hansson") do |profile|
      profile.job_title = "Rails Core, CTO, 37signals"
      profile.bio = "Creator of Ruby on Rails."
      profile.github_url = "https://github.com/dhh"
      profile.linkedin_url = "https://www.linkedin.com/in/david-heinemeier-hansson-374b18221/"
      profile.twitter_url = "https://twitter.com/dhh"
      profile.image = Rails.root.join("#{image_path}/d-hansson.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    eileen_uchitelle_speaker = Profile.find_or_create_by!(name: "Eileen Uchitelle") do |profile|
      profile.job_title = "Rails Core & Senior Staff Engineer, Shopify"
      profile.bio = "Eileen M. Uchitelle is a Senior Staff Engineer at Shopify where she helps lead the effort to improve and maintain the Rails framework and Ruby language. Her approach to solving technical problems centers around ensuring the continued stability and extensibility for individual developers and companies large and small. As a member of the Rails Core Team, her goal is to ensure the long-term sustainability of the Rails framework and its continued adoption as one of the leading open-source frameworks."
      profile.github_url = "https://github.com/eileencodes"
      profile.linkedin_url = "https://www.linkedin.com/in/eileencodes/"
      profile.twitter_url = "https://twitter.com/eileencodes"
      profile.image = Rails.root.join("#{image_path}/e-uchitelle.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    rafael_franca_speaker = Profile.find_or_create_by!(name: "Rafael França") do |profile|
      profile.job_title = "Rails Core & Senior Staff Engineer, Shopify"
      profile.bio = "Rails Core member and technical leader in the Ruby and Rails infrastructure team at Shopify."
      profile.github_url = "https://github.com/rafaelfranca"
      profile.linkedin_url = "https://www.linkedin.com/in/rafaelmfranca/"
      profile.twitter_url = "https://twitter.com/rafaelfranca"
      profile.image = Rails.root.join("#{image_path}/r-franca.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    tobias_luetke_speaker = Profile.find_or_create_by!(name: "Tobias Lütke") do |profile|
      profile.job_title = "CEO, Shopify"
      profile.bio = "Tobi Lütke is the founder and Chief Executive Officer of Shopify. In 2004, Tobi began building software to launch an online snowboard store called Snowdevil. It quickly became obvious that the software was more valuable than the snowboards, so Tobi and his founding team launched the Shopify platform in 2008 built on Rails. Tobi is a vocal advocate for sustainability, computer literacy, and education. He has served as a board member of Coinbase since 2022 and he is actively involved with the open source community, having contributed significantly to Ruby on Rails as one of the earliest members of Rails Core. He also created Liquid and ActiveMerchant, key libraries for ecommerce. Tobi firmly believes that technology is essential for growth and innovation. He is passionate about paving the way for more builders."
      profile.github_url = "https://github.com/tobi"
      profile.linkedin_url = "https://www.linkedin.com/in/tobiaslutke/"
      profile.twitter_url = "https://twitter.com/tobi"
      profile.image = Rails.root.join("#{image_path}/t-lutke.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    xavier_noria_speaker = Profile.find_or_create_by!(name: "Xavier Noria") do |profile|
      profile.job_title = "Rails Core, Zeitwerk, Independent Consultant"
      profile.bio = "Everlasting student · Zeitwerk · Rails Core · Fukuoka Ruby Award · Rails SaaS Conference Award · Ruby Hero Award · Freelance · Life lover"
      profile.github_url = "https://github.com/fxn"
      profile.linkedin_url = "https://www.linkedin.com/in/xaviernoria/"
      profile.twitter_url = "https://twitter.com/fxn"
      profile.image = Rails.root.join("#{image_path}/x-noria.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    andrea_fomera_speaker = Profile.find_or_create_by!(name: "Andrea Fomera") do |profile|
      profile.job_title = "Senior Software Developer, Hire me!"
      profile.bio = "Andrea Fomera is a Senior Software Developer at Podia who finds enjoyment in updating dependencies and crafting high quality, robust and maintainable code. She enjoys sharing what she knows through courses and screencasts."
      profile.github_url = "https://github.com/afomera"
      profile.linkedin_url = "https://www.linkedin.com/in/afomera/"
      profile.twitter_url = "https://twitter.com/afomera"
      profile.image = Rails.root.join("#{image_path}/a-fomera.png").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    bruno_prieto_speaker = Profile.find_or_create_by!(name: "Bruno Prieto") do |profile|
      profile.job_title = "Programmer, 37signals"
      profile.bio = "I’m a blind programmer who fell in love with Rails at first sight, enjoying building web apps that solve real problems while keeping things simple. Whenever I can, I try to collaborate to make the web more accessible for everyone."
      profile.github_url = "https://github.com/brunoprietog"
      profile.linkedin_url = "https://linkedin.com/in/brunoprietog"
      profile.twitter_url = "https://twitter.com/brunoprietog"
      profile.image = Rails.root.join("#{image_path}/b-prieto.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    chris_power_speaker = Profile.find_or_create_by!(name: "Chris Power") do |profile|
      profile.job_title = "Founder, Typecraft"
      profile.bio = "Chris is a seasoned Rails engineer and the face behind the “typecraft” Youtube channel. When not slinging code, Chris is spending time with his Wife of 8 years and coaching T-Ball to his 5-year old twins."
      profile.github_url = "https://github.com/typecraft-dev/"
      profile.linkedin_url = "https://www.linkedin.com/company/typecraft-dev/"
      profile.twitter_url = "https://x.com/typecraft_dev"
      profile.image = Rails.root.join("#{image_path}/c-power.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    david_henner_speaker = Profile.find_or_create_by!(name: "David Henner") do |profile|
      profile.job_title = "Staff Engineer, Zendesk"
      profile.bio = "I’ve been programming in Ruby for almost 19 years. In a past life, I wrote ROR ecommerce which was a large open source e-commerce starter application. Today I work for Zendesk on the Ruby scaling team."
      profile.github_url = "https://github.com/drhenner"
      profile.linkedin_url = "https://www.linkedin.com/in/davidhenner"
      profile.twitter_url = "https://x.com/drhenner"
      profile.image = Rails.root.join("#{image_path}/d-henner.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    donal_mcbreen_speaker = Profile.find_or_create_by!(name: "Donal McBreen") do |profile|
      profile.job_title = "Lead Programmer (Security, Infrastructure and Performance), 37signals"
      profile.bio = "Donal has been a web programmer for over 25 years, working with Rails for the last 10 years. He works in the Security, Infrastructure and Performance (SIP) team at 37signals where he maintains the open source gems Solid Cache and Kamal."
      profile.github_url = "https://github.com/djmb"
      profile.linkedin_url = ""
      profile.twitter_url = "https://www.linkedin.com/in/donal-mcbreen-a8227a52/"
      profile.image = Rails.root.join("#{image_path}/d-mcbreen.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    emmanuel_hayford_speaker = Profile.find_or_create_by!(name: "Emmanuel Hayford") do |profile|
      profile.job_title = "Senior Software Engineer, Curacubby"
      profile.bio = "The Rails Changelog Podcast host, Senior Software Engineer at Curacubby, This Week in Rails co-editor."
      profile.github_url = "https://github.com/siaw23"
      profile.linkedin_url = "https://www.linkedin.com/in/siaw23"
      profile.twitter_url = "https://twitter.com/siaw23"
      profile.image = Rails.root.join("#{image_path}/e-hayford.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    greg_molnar_speaker = Profile.find_or_create_by!(name: "Greg Molnar") do |profile|
      profile.job_title = "Independent Contractor, Spektr Security"
      profile.bio = "I am an independent Rails developer, and OSCP-certified penetration tester."
      profile.github_url = "https://github.com/gregmolnar"
      profile.linkedin_url = "https://www.linkedin.com/in/gregmolnar1/"
      profile.twitter_url = "https://twitter.com/gregmolnar"
      profile.image = Rails.root.join("#{image_path}/g-molnar.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    jamis_buck_speaker = Profile.find_or_create_by!(name: "Jamis Buck") do |profile|
      profile.job_title = "Senior Ruby Software Engineer, DBX, MongoDB"
      profile.bio = "Jamis is a Rails core alumnus, created Capistrano, Net::SSH, SQLite3-Ruby and various other OSS projects, and is the author of “Mazes for Programmers,” and “The Ray-Tracer Challenge.”"
      profile.github_url = "https://github.com/jamis"
      profile.linkedin_url = "https://www.linkedin.com/in/jamis-buck/"
      profile.twitter_url = "https://twitter.com/jamis"
      profile.image = Rails.root.join("#{image_path}/j-buck.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    jenny_shen_speaker = Profile.find_or_create_by!(name: "Jenny Shen") do |profile|
      profile.job_title = "Senior Developer, Shopify"
      profile.bio = "Jenny is a Senior Developer at Shopify, based in Toronto, Canada. She is a RubyGems.org maintainer, and is passionate about open source."
      profile.github_url = "https://github.com/jenshenny"
      profile.linkedin_url = "https://www.linkedin.com/in/jenny-shen-/"
      profile.twitter_url = "https://twitter.com/jenshenny"
      profile.image = Rails.root.join("#{image_path}/j-shen.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    julia_lopez_speaker = Profile.find_or_create_by!(name: "Julia López") do |profile|
      profile.job_title = "Senior Software Engineer, Harvest"
      profile.bio = "I am Julia López and I’ve been working with Rails for over a decade! Currently, I am working as a Senior Software Engineer at Harvest, where we navigate the intricacies of maintaining and enhancing a 17-year-old Rails application. After the conference talks, you can find me at the Karaoke events!"
      profile.github_url = "https://github.com/yukideluxe"
      profile.linkedin_url = "https://www.linkedin.com/in/julialopez/"
      profile.twitter_url = "https://twitter.com/yukideluxe"
      profile.image = Rails.root.join("#{image_path}/j-lopez.png").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    justin_searls_speaker = Profile.find_or_create_by!(name: "Justin Searls") do |profile|
      profile.job_title = "Co-founder, Test Double"
      profile.bio = "Justin is a co-founder Test Double, a consulting agency on a mission to improve how the world builds software. His one gift as a programmer is his ability to cause software to fail. (Which, it turns out, is a surprisingly handy tool in figuring out how to fix it.)"
      profile.github_url = "https://github.com/searls"
      profile.linkedin_url = "https://linkedin.com/in/searls"
      profile.twitter_url = "https://twitter.com/searls"
      profile.image = Rails.root.join("#{image_path}/j-searls.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    kevin_mcconnell_speaker = Profile.find_or_create_by!(name: "Kevin McConnell") do |profile|
      profile.job_title = "Lead Programmer, 37signals"
      profile.bio = "Kevin is a programmer at 37signals, where he writes a lot of Ruby, and sometimes a bit of Go. When he’s not doing that, he enjoys making electronic music and hiking."
      profile.github_url = "https://github.com/kevinmcconnell"
      profile.linkedin_url = ""
      profile.twitter_url = ""
      profile.image = Rails.root.join("#{image_path}/k-mcconnell.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    miles_mcguire_speaker = Profile.find_or_create_by!(name: "Miles McGuire") do |profile|
      profile.job_title = "Staff Engineer, Intercom"
      profile.bio = "Miles has spent 7 years at Intercom working on datastore performance, scalability, and availability from the application layer all the way down."
      profile.github_url = "https://github.com/minuteman3"
      profile.linkedin_url = "https://www.linkedin.com/in/milesmcguire/"
      profile.twitter_url = "https://twitter.com/_minuteman3"
      profile.image = Rails.root.join("#{image_path}/m-mcguire.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    mostafa_abdelraouf_speaker = Profile.find_or_create_by!(name: "Mostafa Abdelraouf") do |profile|
      profile.job_title = "Infrastructure Engineer, Instacart"
      profile.bio = "Mostafa is a Senior Staff Software Engineer on the Infrastructure team at Instacart his focus is on the data access layer between Rails and Postgres, he also contributes to PgCat (A PostgreSQL connection pool written in Rust)."
      profile.github_url = ""
      profile.linkedin_url = ""
      profile.twitter_url = ""
      profile.image = Rails.root.join("#{image_path}/m-abdelraouf.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    obie_fernandez_speaker = Profile.find_or_create_by!(name: "Obie Fernandez") do |profile|
      profile.job_title = "Author of The Rails Way, and Chief Scientist, Olympia"
      profile.bio = "With 30 years in tech and 2 decades in Ruby, Obie, author of “The Rails Way,” is a pivotal and well-loved figure. As co-founder and sole engineer of Olympia, a Rails-based AI startup, he exemplifies building scalable applications with the “One Person Framework”."
      profile.github_url = "https://github.com/obie"
      profile.linkedin_url = "https://www.linkedin.com/in/obiefernandez/"
      profile.twitter_url = "https://twitter.com/obie"
      profile.image = Rails.root.join("#{image_path}/o-fernandez.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    ridhwana_khan_speaker = Profile.find_or_create_by!(name: "Ridhwana Khan") do |profile|
      profile.job_title = "Lead Software Engineer & Writer"
      profile.bio = "Ridhwana Khan is a Lead Engineer, an entrepreneur, and a technical writer for the Ruby on Rails Guides. She is driven by the satisfaction of building systems that positively impact people’s lives. She enjoys mentoring, speaking at conferences, and community building."
      profile.github_url = "https://github.com/ridhwana"
      profile.linkedin_url = "https://www.linkedin.com/in/ridhwanakhan/"
      profile.twitter_url = "https://twitter.com/Ridhwana_K"
      profile.image = Rails.root.join("#{image_path}/r-khan.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    robby_russell_speaker = Profile.find_or_create_by!(name: "Robby Russell") do |profile|
      profile.job_title = "CEO, Planet Argon"
      profile.bio = "Co-founder of Planet Argon, Host of Maintainable Software Podcast, and Creator of Oh My Zsh."
      profile.github_url = "https://github.com/robbyrussell"
      profile.linkedin_url = "https://www.linkedin.com/in/robbyrussell/"
      profile.twitter_url = "https://twitter.com/robbyrussell"
      profile.image = Rails.root.join("#{image_path}/r-russell.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    robert_beene_speaker = Profile.find_or_create_by!(name: "Robert Beene") do |profile|
      profile.job_title = "Founder, Typecraft"
      profile.bio = "Robert has been working with Rails for nearly 20 years, helping clients deliver solutions in the healthcare space. When I’m not building apps with my team, I’m raising three kids in the heart of NYC."
      profile.github_url = "https://github.com/typecraft-dev/"
      profile.linkedin_url = "https://www.linkedin.com/company/typecraft-dev/"
      profile.twitter_url = "https://x.com/typecraftHQ"
      profile.image = Rails.root.join("#{image_path}/r-beene.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    rosa_gutierrez_speaker = Profile.find_or_create_by!(name: "Rosa Gutierrez") do |profile|
      profile.job_title = "Principal programmer, 37signals"
      profile.bio = "European. Loves cities, mathematics, theoretical computer science, learning languages for humans and computers, puzzles & bicycles. Human to Mochi."
      profile.github_url = "https://github.com/rosa"
      profile.linkedin_url = "https://www.linkedin.com/in/rosagutierrezescudero/"
      profile.twitter_url = "https://twitter.com/rosapolis"
      profile.image = Rails.root.join("#{image_path}/r-gutierrez.jpg").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    stephen_margheim_speaker = Profile.find_or_create_by!(name: "Stephen Margheim") do |profile|
      profile.job_title = "Rubyist, Web Developer, and Engineering Manager, Test IO"
      profile.bio = "Hey, I’m Stephen. I’m an American expat living in Berlin with my wife and two dogs. I am a contributor to Rails and the sqlite3-ruby gem as well as the maintainer of a handful of gems aimed at making Ruby and Rails the absolute best platforms in the world to run SQLite projects."
      profile.github_url = "https://github.com/fractaledmind"
      profile.linkedin_url = "https://www.linkedin.com/in/stephen-margheim-5aa25bb8/"
      profile.twitter_url = "https://twitter.com/fractaledmind"
      profile.image = Rails.root.join("#{image_path}/s-margheim.png").open
      Speaker.find_or_create_by!(profile: profile)
    end.profileable

    # Create Sessions
    Session.find_or_create_by!(
      conference: conference,
      title: "Doors Open",
      starts_at: Time.zone.local(2024, month, start_day, 9, 0)
    ) do |session|
      session.description = "Rails World attendees are welcome to register, enter, and grab a coffee and light breakfast before the keynote begins."
      session.ends_at = Time.zone.local(2024, month, start_day, 9, 45)
      session.location = sponsor_garden
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Opening Keynote",
      starts_at: Time.zone.local(2024, month, start_day, 9, 45)
    ) do |session|
      session.description = "DHH will kick off the second edition of Rails World in Toronto with an Opening Keynote highlighting what is new in Rails today, and where the framework is headed tomorrow."
      session.ends_at = Time.zone.local(2024, month, start_day, 11, 0)
      session.location = track_1
      session.speakers = [david_heinemeier_hansson_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Solid Queue internals, externals and all the things in between",
      starts_at: Time.zone.local(2024, month, start_day, 11, 15)
    ) do |session|
      session.description = "We’ve used Resque and Redis to run background jobs in multiple apps for many years at 37signals. However, performance, reliability, and our own apps’ idiosyncrasies led us to use a lot of different gems, some developed by us, some forked or patched to address our struggles. After multiple war stories with background jobs, looking at our increasingly complex setup, we wanted something we could use out-of-the-box without having to port our collection of hacks to every new app and with fewer moving pieces. After exploring existing alternatives, we decided to build our own and aim to make it the default for Rails 8. In this talk, I’ll present Solid Queue, explain some of the problems we had over the years, how we designed Solid Queue to address them, and all the Fun™ we had doing that."
      session.ends_at = Time.zone.local(2024, month, start_day, 11, 45)
      session.location = track_1
      session.speakers = [rosa_gutierrez_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Going beyond a Single Postgres Instance with Rails",
      starts_at: Time.zone.local(2024, month, start_day, 11, 15)
    ) do |session|
      session.description = "We’ll look at the journey of evolving Instacart’s Rails application beyond a single Postgres instance, how we managed the added complexity from adding read replicas, and later vertically and horizontally sharding. We’ll touch on some topics around query routing, connection pooling and load balancing."
      session.ends_at = Time.zone.local(2024, month, start_day, 11, 45)
      session.location = track_2
      session.speakers = [mostafa_abdelraouf_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "What to do in the breaks",
      starts_at: Time.zone.local(2024, month, start_day, 11, 45)
    ) do |session|
      session.description = "<p> During lunch and breaks between sessions on both days, attendees can: </p> <ul> <li> Catch 10-15 min Community talks on the Lightning Track (sponsored by Shopify) </li> <li> Chat with our sponsors in the Sponsor Garden </li> <li> Hang out in the Shopify Lounge </li> <li> Follow a workshop (sponsored by Coder) </li> <li> Drop by the Test Double Office Hours for pair programming and career advice </li> <li> Explore the historic venue </li> <li> Take a walk in the nature park located behind the venue </li> <li> Grab an espresso or latte from the coffee carts (sponsored by Cedarcode) </li> <li> Or grab an item from the Food Trucks (sponsored by Shopify) </li> </ul> <p> There will be an official Rails World app by Telos Labs so attendees can build their schedule. </p>"
      session.ends_at = Time.zone.local(2024, month, start_day, 13, 0)
      session.location = break_location
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "The Modern Programmer’s Guide to Neovim and Zellij",
      starts_at: Time.zone.local(2024, month, start_day, 13, 0)
    ) do |session|
      session.description = "<p> Are you ready to revolutionize your coding environment? In a world dominated by VS Code and other Electron-based editors, there's a hidden gem that developers are rediscovering: Vim. Or rather, Neovim. Just as Rails transformed web development, Neovim is redefining how we write code, blending decades-old technology with modern tooling for an unparalleled experience. </p> <p> <strong>Workshop overview </strong>In this hands-on workshop, we dive into the world of Neovim and Zellij —showing you how to streamline your development process and achieve a true flow state. </p> <p> <strong>Here's what you can expect</strong> </p> <ul style='list-style: initial;'> <li> Introduction to Neovim: Understand the core principles that make Neovim a game-changer in the modern programming landscape. </li> <li> Learn how to effortlessly manage and customize plugins to suit your unique work-flow, shedding the bloat of heavier editors. </li> <li> Combine the power of Neovim and Zellij to increase developer productivity by achieving your optimal flow state. </li> </ul> <p> <strong>Key takeaways</strong> By the end of this 75-minute workshop, you will: </p> <ul style='list-style: initial;'> <li> Have a solid understanding of Neovim's capabilities and how it can enhance your productivity. </li> <li> Manage workspaces using Zellij to jump in and out of projects with ease. </li> <li> Walk away with a Neovim setup that empowers you to code with minimal distractions, maximizing your efficiency and creativity. </li> </ul> <p> <strong>Why Attend?</strong> This workshop is perfect for developers of all levels (with some famil- iarity with Vim) who are looking to optimize their workflow and embrace a light- weight, powerful, and highly customizable editor. Whether you're new to Neovim or looking to deepen your understanding, this session will provide you with practical skills and insights that you can apply immediately. </p> <p> <strong>Thank you Coder!</strong> This workshop is brought to you by <a href='https://coder.com/'>Coder</a>, and will be repeated on both days. It will be first-come, first-served. </p>"
      session.ends_at = Time.zone.local(2024, month, start_day, 14, 15)
      session.location = lightning_track
      session.speakers = [chris_power_speaker, robert_beene_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Kamal 2.0 - Deploy web apps anywhere",
      starts_at: Time.zone.local(2024, month, start_day, 13, 0)
    ) do |session|
      session.description = "Kamal is an imperative deployment tool from 37signals for running your apps with Docker. We’ll run through how it works, what we’ve learned from v1.0, and the changes we’ve made for v2.0."
      session.ends_at = Time.zone.local(2024, month, start_day, 13, 30)
      session.location = track_1
      session.speakers = [donal_mcbreen_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Repurposing the Rails CLI",
      starts_at: Time.zone.local(2024, month, start_day, 13, 0)
    ) do |session|
      session.description = "The Rails CLI works great for the vast majority of us, but what do you do when it doesn’t? At MongoDB, we recently wanted to add a tighter integration between Rails and Mongoid (our ODM), and were able to create our own CLI tool that extends the Rails CLI, overriding the pieces that weren’t compatible or relevant and extending it with the functionality we wanted. I’ll show you how we did it, and how you can do it yourself."
      session.ends_at = Time.zone.local(2024, month, start_day, 13, 30)
      session.location = track_2
      session.speakers = [jamis_buck_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Introducing Kamal Proxy",
      starts_at: Time.zone.local(2024, month, start_day, 13, 45)
    ) do |session|
      session.description = "Kamal Proxy is a new, purpose-built HTTP proxy service that powers Kamal 2.0. It’s designed to make zero-downtime deployments simpler, and comes with additional features to make your Rails applications faster and easier to operate. In this talk, we’ll look at what Kamal Proxy does, why we built it, and how it works."
      session.ends_at = Time.zone.local(2024, month, start_day, 14, 15)
      session.location = track_1
      session.speakers = [kevin_mcconnell_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "The state of security in Rails 8",
      starts_at: Time.zone.local(2024, month, start_day, 13, 45)
    ) do |session|
      session.description = "Security is a crucial aspect of any web application and Rails is one of the best options for an application with high security standards. In this talk, I will highlight the recent security related improvements in Rails."
      session.ends_at = Time.zone.local(2024, month, start_day, 14, 15)
      session.location = track_2
      session.speakers = [greg_molnar_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "An upgrade handbook to Rails 8",
      starts_at: Time.zone.local(2024, month, start_day, 14, 45)
    ) do |session|
      session.description = "Each new major version of Rails unlocks so many great features, and Rails 8 is no exception. However, upgrading a Rails application can be difficult. This talk will look at ways to address the major changes for Rails 8 to get your Rails app prepared to run on the latest version in no time! We’ll also explore how Shopify was able to automate the Rails upgrade process for hundreds of their applications."
      session.ends_at = Time.zone.local(2024, month, start_day, 15, 15)
      session.location = track_1
      session.speakers = [jenny_shen_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "The Empowered Programmer",
      starts_at: Time.zone.local(2024, month, start_day, 14, 45)
    ) do |session|
      session.description = "In 2021, DHH dubbed Rails, 'The One Person Framework.' Is it? This talk will explore how Rails 7 equips solo developers more than ever before. Drawing from personal experience, I'll share how building a new app with Rails 7 felt like half the work of my previous Rails 5 project. You'll learn about the benefits of sticking with omakase, how Rails includes more batteries than ever, and why scaling back a team doesn't have to mean slowing down."
      session.ends_at = Time.zone.local(2024, month, start_day, 15, 15)
      session.location = track_2
      session.speakers = [justin_searls_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Frontiers of development productivity in Rails",
      starts_at: Time.zone.local(2024, month, start_day, 15, 45)
    ) do |session|
      session.description = "Rails is known to be one of the best frameworks in terms of empowering developers to build great products, and has kept this place for 20 years. Can we do better? In this talk, we will see how we are pushing Rails to continue making developers lives easier in new frontiers."
      session.ends_at = Time.zone.local(2024, month, start_day, 16, 15)
      session.location = track_1
      session.speakers = [rafael_franca_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Progressive Web Apps for Rails developers",
      starts_at: Time.zone.local(2024, month, start_day, 15, 45)
    ) do |session|
      session.description = "Explore the evolving world of Progressive Web Apps (PWAs), built with familiar Rails technologies and designed for seamless use in all compatible browsers. Rails 8 promises to simplify PWA development, offering innovative methods to swiftly generate essential PWA scaffolding. This talk covers PWA basics, their inner workings, and Rails 8’s crucial development role. We’ll examine service worker lifecycle, offline strategies via background sync, and the CacheStorage API for cross-device performance. Additionally, we’ll investigate local data storage via IndexDB and exploiting Push Notifications to elevate the user experience to that of native applications."
      session.ends_at = Time.zone.local(2024, month, start_day, 16, 15)
      session.location = track_2
      session.speakers = [emmanuel_hayford_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Matz & DHH Fireside chat, hosted by Tobias Lütke",
      starts_at: Time.zone.local(2024, month, start_day, 16, 30)
    ) do |session|
      session.description = "We are pleased to welcome Ruby creator and special guest Yukihiro Matsumoto (Matz) to the Rails World stage for a fireside chat with Rails creator David Heinemeier Hansson (DHH). Together on stage for the very first time! Hosted by Shopify founder Tobias Lütke, this is sure to be a conversation you don’t want to miss."
      session.ends_at = Time.zone.local(2024, month, start_day, 17, 30)
      session.location = track_1
      session.speakers = [matz_speaker, david_heinemeier_hansson_speaker, tobias_luetke_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "What to do in the breaks",
      starts_at: Time.zone.local(2024, month, start_day, 19, 0)
    ) do |session|
      session.description = "<p>Come hang out with the local Toronto Ruby meetup group. Grab a beer and have a bite, and recharge for Day 2.</p> <p>This evening event wouldn’t be possible without the generous support and sponsorship of our Gold sponsor, Clio. Stop by their booth for a ticket to the event. Badges still required.</p>"
      session.ends_at = Time.zone.local(2024, month, start_day, 22, 30)
      session.location = tbd_location
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Doors Open",
      starts_at: Time.zone.local(2024, month, second_day, 9, 0)
    ) do |session|
      session.description = "Rails World attendees are welcome to register, enter, and grab a coffee before the keynote begins."
      session.ends_at = Time.zone.local(2024, month, second_day, 10, 0)
      session.location = sponsor_lounge
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Opening Keynote",
      starts_at: Time.zone.local(2024, month, second_day, 10, 0)
    ) do |session|
      session.description = "More information coming soon."
      session.ends_at = Time.zone.local(2024, month, second_day, 11, 0)
      session.location = track_1
      session.speakers = [eileen_uchitelle_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "SQLite on Rails - Busting myths and supercharging the One-Person Framework",
      starts_at: Time.zone.local(2024, month, second_day, 11, 15)
    ) do |session|
      session.description = "Rails 8 takes the 'one-person framework' to new heights. Enhancements to the SQLite adapter and the suite of Solid libraries now cement its standing as the top choice for solo developers and small teams. This talk will bust myths with benchmarks, showcase scalability with case studies, and sidestep pitfalls with practical tips. Concrete, real-world examples will illustrate how the Rails 8 feature set perfectly complements SQLite’s power in creating resilient, high-performance production apps. You’ll leave with a solid understanding of when SQLite does and doesn’t make sense for your application and how to leverage Rails and SQLite’s full potential in your next production venture."
      session.ends_at = Time.zone.local(2024, month, second_day, 11, 45)
      session.location = track_1
      session.speakers = [stephen_margheim_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Demystifying some of the magic behind Rails",
      starts_at: Time.zone.local(2024, month, second_day, 11, 15)
    ) do |session|
      session.description = "Rails is renowned for its elegance, productivity, and 'magic' that simplifies web development. As a recent technical writer for the official Ruby on Rails guides, I’ve had the opportunity to dive into the 'magic' of Rails to enhance my understanding of the source code and provide clear explanations in the guides. In this talk, I’ll share my journey of inspecting modules, exploring concepts, and sharing insights gained from my experience to help attendees better understand how some Rails components work internally. Whether you are a beginner eager to understand the framework’s foundations or an experienced developer looking to deepen your knowledge, this dive into the source code will enhance your proficiency and demystify the framework’s inner workings."
      session.ends_at = Time.zone.local(2024, month, second_day, 11, 45)
      session.location = track_2
      session.speakers = [ridhwana_khan_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "What to do in the breaks",
      starts_at: Time.zone.local(2024, month, second_day, 11, 45)
    ) do |session|
      session.description = "<p> During lunch and breaks between sessions on both days, attendees can: </p> <ul> <li> Catch 10-15 min Community talks on the Lightning Track (sponsored by Shopify) </li> <li> Chat with our sponsors in the Sponsor Garden </li> <li> Hang out in the Shopify Lounge </li> <li> Follow a workshop (sponsored by Coder) </li> <li> Drop by the Test Double Office Hours for pair programming and career advice </li> <li> Explore the historic venue </li> <li> Take a walk in the nature park located behind the venue </li> <li> Grab an espresso or latte from the coffee carts (sponsored by Cedarcode) </li> <li> Or grab an item from the Food Trucks (sponsored by Shopify) </li> </ul> <p> There will be an official Rails World app by Telos Labs so attendees can build their schedule. </p>"
      session.ends_at = Time.zone.local(2024, month, second_day, 13, 0)
      session.location = break_location
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Making the best of a bad situation - Lessons from one of Intercom’s most painful outages",
      starts_at: Time.zone.local(2024, month, second_day, 13, 0)
    ) do |session|
      session.description = "On 22 Feb 2024 Intercom had one of its most painful outages in recent memory. The root cause? A 32-bit foreign key referencing a 64-bit primary key. We’ll take a look at what happened, why it happened, and what we did to ensure it didn’t happen again, including some changes you can make to your own Rails apps to help make sure you don’t make the same mistakes."
      session.ends_at = Time.zone.local(2024, month, second_day, 13, 30)
      session.location = track_1
      session.speakers = [miles_mcguire_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Pushing the boundaries with ActiveStorage",
      starts_at: Time.zone.local(2024, month, second_day, 13, 0)
    ) do |session|
      session.description = "In this talk you’ll learn how to push the boundaries with ActiveStorage and leverage it to build feature rich user experiences. You’ll learn how to build custom services to integrate with external providers that go above and beyond the built in services to allow users to select images from a third party API that hosts images for you, and a rich media library that allows users to see, modify and upload files they’ve uploaded that can be selected from in forms in place of uploading a new file."
      session.ends_at = Time.zone.local(2024, month, second_day, 13, 30)
      session.location = track_2
      session.speakers = [andrea_fomera_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Making accessible web apps with Rails and Hotwire",
      starts_at: Time.zone.local(2024, month, second_day, 13, 45)
    ) do |session|
      session.description = "Nowadays, there is a lot of talk about accessibility, but is your web app accessible? In this session, I will share my perspective as a blind developer on how to build accessible web apps with real-world examples, beyond saying it’s important and the need to use ARIA. I will start by demonstrating how a blind person uses a screen reader to navigate the web, so that you can understand the most common challenges faced by blind people every day. This will help clarify several requirements that people currently spend too much time on. Instead, we can focus on the most relevant errors and aspects to bear in mind when developing and designing interfaces. We will cover the most common patterns with code examples, taking advantage of tools provided by Rails, Hotwire, and the browser."
      session.ends_at = Time.zone.local(2024, month, second_day, 14, 15)
      session.location = track_1
      session.speakers = [bruno_prieto_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "The Modern Programmer’s Guide to Neovim and Zellij",
      starts_at: Time.zone.local(2024, month, second_day, 13, 0)
    ) do |session|
      session.description = "<p> Are you ready to revolutionize your coding environment? In a world dominated by VS Code and other Electron-based editors, there's a hidden gem that developers are rediscovering: Vim. Or rather, Neovim. Just as Rails transformed web development, Neovim is redefining how we write code, blending decades-old technology with modern tooling for an unparalleled experience. </p> <p> <strong>Workshop overview </strong>In this hands-on workshop, we dive into the world of Neovim and Zellij —showing you how to streamline your development process and achieve a true flow state. </p> <p> <strong>Here's what you can expect</strong> </p> <ul style='list-style: initial;'> <li> Introduction to Neovim: Understand the core principles that make Neovim a game-changer in the modern programming landscape. </li> <li> Learn how to effortlessly manage and customize plugins to suit your unique work-flow, shedding the bloat of heavier editors. </li> <li> Combine the power of Neovim and Zellij to increase developer productivity by achieving your optimal flow state. </li> </ul> <p> <strong>Key takeaways</strong> By the end of this 75-minute workshop, you will: </p> <ul style='list-style: initial;'> <li> Have a solid understanding of Neovim's capabilities and how it can enhance your productivity. </li> <li> Manage workspaces using Zellij to jump in and out of projects with ease. </li> <li> Walk away with a Neovim setup that empowers you to code with minimal distractions, maximizing your efficiency and creativity. </li> </ul> <p> <strong>Why Attend?</strong> This workshop is perfect for developers of all levels (with some famil- iarity with Vim) who are looking to optimize their workflow and embrace a light- weight, powerful, and highly customizable editor. Whether you're new to Neovim or looking to deepen your understanding, this session will provide you with practical skills and insights that you can apply immediately. </p> <p> <strong>Thank you Coder!</strong> This workshop is brought to you by <a href='https://coder.com/'>Coder</a>, and will be repeated on both days. It will be first-come, first-served. </p>"
      session.ends_at = Time.zone.local(2024, month, second_day, 14, 15)
      session.location = lightning_track
      session.speakers = [chris_power_speaker, robert_beene_speaker]
    end

    Session.find_or_create_by(
      conference: conference,
      title: "Prepare to tack - Steering Rails apps out of technical debt",
      starts_at: Time.zone.local(2024, month, second_day, 13, 45)
    ) do |session|
      session.description = "Spoiler alert: we’ve been wrong about tech debt. Our Rails apps are drowning in a sea of compromises and quick fixes, making it difficult to update and slowing us down. It’s high time we redefine “technical debt” — perhaps even time to ditch the term altogether. In this talk, we’re not only exploring the common issues facing our Rails apps; we’re going deeper. We’ll uncover roadblocks, blind spots, and comfort zones that lead us to rationalize away the need for necessary changes. By confronting these excuses head-on, we’re not just aiming to fix immediate problems; we’re working towards a more maintainable, efficient codebase. Whether you’re part of a duo or sailing with a crew of several dozen, this session charts a course for tackling what truly matters. It’s time to grab the wheel."
      session.ends_at = Time.zone.local(2024, month, second_day, 14, 15)
      session.location = track_2
      session.speakers = [robby_russell_speaker]
    end

    Session.find_or_create_by(
      conference: conference,
      title: "The Rails Boot Process",
      starts_at: Time.zone.local(2024, month, second_day, 14, 45)
    ) do |session|
      session.description = "In this talk we’ll cover what happens when a Rails application boots. When is the logger ready? When is $LOAD_PATH set? When do initializers run or when are the autoloaders set up? Basically, we’ll understand what runs when. Also, we’ll understand railties and engines initializers, which are key to this process."
      session.ends_at = Time.zone.local(2024, month, second_day, 15, 15)
      session.location = track_1
      session.speakers = [xavier_noria_speaker]
    end

    Session.find_or_create_by(
      conference: conference,
      title: "Testing Integrations - The Good, the Bad, and the Ugly",
      starts_at: Time.zone.local(2024, month, second_day, 14, 45)
    ) do |session|
      session.description = "Does your Rails app have integrations with third-party APIs? Perhaps your billing system relies on a subscription management tool, or you utilize email marketing applications to engage customers? Enhancing your features through external tools can be powerful, but testing these integrations could pose challenges or be cumbersome. Join me as we explore practical strategies for testing integrations, drawing from real-life experiences at Harvest, where we implemented several integrations – Braintree, Stripe, CustomerIO, Hubspot, Xero, QuickBooks, and more – and gain confidence in safeguarding your codebase during refactorings or API version changes."
      session.ends_at = Time.zone.local(2024, month, second_day, 15, 15)
      session.location = track_2
      session.speakers = [julia_lopez_speaker]
    end

    Session.find_or_create_by(
      conference: conference,
      title: "Empowering the Individual - Rails on AI",
      starts_at: Time.zone.local(2024, month, second_day, 15, 45)
    ) do |session|
      session.description = "The dream of the “One Person Framework” is more tangible than ever. Integrating AI with Ruby on Rails can transform a solo developer’s workflow into an incredibly potent force, capable of competing at an unprecedented scale. This presentation draws on practical real-world experience. We will explore practical approaches ranging from code generation to real-time data analysis and automated customer support. The emphasis is on new tools that let developers focus more than ever on innovation and creativity. Attendees will leave with a roadmap for integrating AI tools and techniques into their Rails projects, insights into the potential pitfalls and best practices, and inspiration to explore the boundaries of what a single developer or a small team can achieve with the right tools."
      session.ends_at = Time.zone.local(2024, month, second_day, 16, 15)
      session.location = track_1
      session.speakers = [obie_fernandez_speaker]
    end
    Session.find_or_create_by(
      conference: conference,
      title: "Level up performance with simple coding changes",
      starts_at: Time.zone.local(2024, month, second_day, 15, 45)
    ) do |session|
      session.description = "This presentation will first highlight some of the major improvements Zendesk has achieved using straightforward Ruby techniques. Data will illustrate the saving of thousands of years of processing time annually, leading to increased customer satisfaction and cost-effectiveness, as reflected in our AWS bills. Fortunately, many of these enhancements are straightforward to implement from day one. My goal is to show folks how to incorporate these types of improvements early in their development process and share my learnings with the broader community."
      session.ends_at = Time.zone.local(2024, month, second_day, 16, 15)
      session.location = track_2
      session.speakers = [david_henner_speaker]
    end

    Session.find_or_create_by(
      conference: conference,
      title: "Closing Keynote",
      starts_at: Time.zone.local(2024, month, second_day, 16, 30)
    ) do |session|
      session.description = "More information coming soon."
      session.ends_at = Time.zone.local(2024, month, second_day, 17, 30)
      session.location = track_1
      session.speakers = [aaron_patterson_speaker]
    end

    Session.find_or_create_by!(
      conference: conference,
      title: "Shopify Closing Party",
      starts_at: Time.zone.local(2024, month, second_day, 19, 0)
    ) do |session|
      session.description = "Join us as we close out Rails World with a takeover at the Shopify Port. Three floors of music, games, food, drink, and fun, with plenty of space for pair programming if you have any code you need to tackle. Pre-registration will be required (attendees will be sent more details). Don’t forget your badge!"
      session.ends_at = Time.zone.local(2024, month, second_day, 22, 0)
      session.location = shopify_port
    end
  end
end

month = ENV["MONTH_NUMBER"].present? ? ENV["MONTH_NUMBER"].to_i : 9
start_day = ENV["DAY_NUMBER"].present? ? ENV["DAY_NUMBER"].to_i : 26
second_day = start_day + 1
image_path = "db/images"

# Create admin
user = User.find_or_initialize_by(email: "admin@example.com", role: "admin")
user.assign_attributes(password: "foobar2024", password_confirmation: "foobar2024")
user.save!

# Clean up existing data
Session.destroy_all
Speaker.destroy_all
Tag.destroy_all
Location.destroy_all
Conference.destroy_all

# Create Conference
conference = Conference.find_or_create_by!(name: "Rails World 2024")

# Create Locations
track_1 = conference.locations.create(name: "Track 1")
track_2 = conference.locations.create(name: "Track 2")
lightning_track = conference.locations.create(name: "Lightning Track")

# Create Tags
# No tags for now

# Create Speakers
matz_speaker = Speaker.create!(
  name: "Yukihiro \"Matz\" Matsumoto",
  job_title: "Creator of Ruby",
  bio: "Matz is the creator and chief designer of the Ruby programming language.",
  github_url: "https://github.com/matz",
  linkedin_url: "",
  twitter_url: "https://x.com/yukihiro_matz",
  image: Rails.root.join("#{image_path}/m-matsumoto.jpg").open
)

aaron_patterson_speaker = Speaker.create!(
  name: "Aaron Patterson",
  job_title: "Rails Core & Senior Staff Engineer, Shopify",
  bio: "Aaron is on the Rails core team, the Ruby core team, and is a Senior Staff Engineer working at Shopify. In his free time, he enjoys cooking, playing with cats, and writing weird software.",
  github_url: "https://github.com/tenderlove",
  linkedin_url: "https://www.linkedin.com/in/tenderlove/",
  twitter_url: "https://twitter.com/tenderlove",
  image: Rails.root.join("#{image_path}/a-patterson.jpg").open
)

david_heinemeier_hansson_speaker = Speaker.create!(
  name: "David Heinemeier Hansson",
  job_title: "Rails Core, CTO, 37signals",
  bio: "Creator of Ruby on Rails.",
  github_url: "https://github.com/dhh",
  linkedin_url: "https://www.linkedin.com/in/david-heinemeier-hansson-374b18221/",
  twitter_url: "https://twitter.com/dhh",
  image: Rails.root.join("#{image_path}/d-hansson.jpg").open
)

eileen_uchitelle_speaker = Speaker.create!(
  name: "Eileen Uchitelle",
  job_title: "Rails Core & Senior Staff Engineer, Shopify",
  bio: "Eileen M. Uchitelle is a Senior Staff Engineer at Shopify where she helps lead the effort to improve and maintain the Rails framework and Ruby language. Her approach to solving technical problems centers around ensuring the continued stability and extensibility for individual developers and companies large and small. As a member of the Rails Core Team, her goal is to ensure the long-term sustainability of the Rails framework and its continued adoption as one of the leading open-source frameworks.",
  github_url: "https://github.com/eileencodes",
  linkedin_url: "https://www.linkedin.com/in/eileencodes/",
  twitter_url: "https://twitter.com/eileencodes",
  image: Rails.root.join("#{image_path}/e-uchitelle.jpg").open
)

rafael_franca_speaker = Speaker.create!(
  name: "Rafael França",
  job_title: "Rails Core & Senior Staff Engineer, Shopify",
  bio: "Rails Core member and technical leader in the Ruby and Rails infrastructure team at Shopify.",
  github_url: "https://github.com/rafaelfranca",
  linkedin_url: "https://www.linkedin.com/in/rafaelmfranca/",
  twitter_url: "https://twitter.com/rafaelfranca",
  image: Rails.root.join("#{image_path}/r-franca.jpg").open
)

tobias_luetke_speaker = Speaker.create!(
  name: "Tobias Lütke",
  job_title: "CEO, Shopify",
  bio: "Tobi Lütke is the founder and Chief Executive Officer of Shopify. In 2004, Tobi began building software to launch an online snowboard store called Snowdevil. It quickly became obvious that the software was more valuable than the snowboards, so Tobi and his founding team launched the Shopify platform in 2008 built on Rails. Tobi is a vocal advocate for sustainability, computer literacy, and education. He has served as a board member of Coinbase since 2022 and he is actively involved with the open source community, having contributed significantly to Ruby on Rails as one of the earliest members of Rails Core. He also created Liquid and ActiveMerchant, key libraries for ecommerce. Tobi firmly believes that technology is essential for growth and innovation. He is passionate about paving the way for more builders.",
  github_url: "https://github.com/tobi",
  linkedin_url: "https://www.linkedin.com/in/tobiaslutke/",
  twitter_url: "https://twitter.com/tobi",
  image: Rails.root.join("#{image_path}/t-lutke.jpg").open
)

xavier_noria_speaker = Speaker.create!(
  name: "Xavier Noria",
  job_title: "Rails Core, Zeitwerk, Independent Consultant",
  bio: "Everlasting student · Zeitwerk · Rails Core · Fukuoka Ruby Award · Rails SaaS Conference Award · Ruby Hero Award · Freelance · Life lover",
  github_url: "https://github.com/fxn",
  linkedin_url: "https://www.linkedin.com/in/xaviernoria/",
  twitter_url: "https://twitter.com/fxn",
  image: Rails.root.join("#{image_path}/x-noria.jpg").open
)

andrea_fomera_speaker = Speaker.create!(
  name: "Andrea Fomera",
  job_title: "Senior Software Developer, Hire me!",
  bio: "Andrea Fomera is a Senior Software Developer at Podia who finds enjoyment in updating dependencies and crafting high quality, robust and maintainable code. She enjoys sharing what she knows through courses and screencasts.",
  github_url: "https://github.com/afomera",
  linkedin_url: "https://www.linkedin.com/in/afomera/",
  twitter_url: "https://twitter.com/afomera",
  image: Rails.root.join("#{image_path}/a-fomera.png").open
)

bruno_prieto_speaker = Speaker.create!(
  name: "Bruno Prieto",
  job_title: "Programmer, 37signals",
  bio: "I’m a blind programmer who fell in love with Rails at first sight, enjoying building web apps that solve real problems while keeping things simple. Whenever I can, I try to collaborate to make the web more accessible for everyone.",
  github_url: "https://github.com/brunoprietog",
  linkedin_url: "https://linkedin.com/in/brunoprietog",
  twitter_url: "https://twitter.com/brunoprietog",
  image: Rails.root.join("#{image_path}/b-prieto.jpg").open
)

chris_power_speaker = Speaker.create!(
  name: "Chris Power",
  job_title: "Founder, Typecraft",
  bio: "Chris is a seasoned Rails engineer and the face behind the “typecraft” Youtube channel. When not slinging code, Chris is spending time with his Wife of 8 years and coaching T-Ball to his 5-year old twins.",
  github_url: "https://github.com/typecraft-dev/",
  linkedin_url: "https://www.linkedin.com/company/typecraft-dev/",
  twitter_url: "https://x.com/typecraft_dev",
  image: Rails.root.join("#{image_path}/c-power.jpg").open
)

david_henner_speaker = Speaker.create!(
  name: "David Henner",
  job_title: "Staff Engineer, Zendesk",
  bio: "I’ve been programming in Ruby for almost 19 years. In a past life, I wrote ROR ecommerce which was a large open source e-commerce starter application. Today I work for Zendesk on the Ruby scaling team.",
  github_url: "https://github.com/drhenner",
  linkedin_url: "https://www.linkedin.com/in/davidhenner",
  twitter_url: "https://x.com/drhenner",
  image: Rails.root.join("#{image_path}/d-henner.jpg").open
)

donal_mcbreen_speaker = Speaker.create!(
  name: "Donal McBreen",
  job_title: "Lead Programmer (Security, Infrastructure and Performance), 37signals",
  bio: "Donal has been a web programmer for over 25 years, working with Rails for the last 10 years. He works in the Security, Infrastructure and Performance (SIP) team at 37signals where he maintains the open source gems Solid Cache and Kamal.",
  github_url: "https://github.com/djmb",
  linkedin_url: "",
  twitter_url: "https://www.linkedin.com/in/donal-mcbreen-a8227a52/",
  image: Rails.root.join("#{image_path}/d-mcbreen.jpg").open
)

emmanuel_hayford_speaker = Speaker.create!(
  name: "Emmanuel Hayford",
  job_title: "Senior Software Engineer, Curacubby",
  bio: "The Rails Changelog Podcast host, Senior Software Engineer at Curacubby, This Week in Rails co-editor.",
  github_url: "https://github.com/siaw23",
  linkedin_url: "https://www.linkedin.com/in/siaw23",
  twitter_url: "https://twitter.com/siaw23",
  image: Rails.root.join("#{image_path}/e-hayford.jpg").open
)

greg_molnar_speaker = Speaker.create!(
  name: "Greg Molnar",
  job_title: "Independent Contractor, Spektr Security",
  bio: "I am an independent Rails developer, and OSCP-certified penetration tester.",
  github_url: "https://github.com/gregmolnar",
  linkedin_url: "https://www.linkedin.com/in/gregmolnar1/",
  twitter_url: "https://twitter.com/gregmolnar",
  image: Rails.root.join("#{image_path}/g-molnar.jpg").open
)

jamis_buck_speaker = Speaker.create!(
  name: "Jamis Buck",
  job_title: "Senior Ruby Software Engineer, DBX, MongoDB",
  bio: "Jamis is a Rails core alumnus, created Capistrano, Net::SSH, SQLite3-Ruby and various other OSS projects, and is the author of “Mazes for Programmers,” and “The Ray-Tracer Challenge.”",
  github_url: "https://github.com/jamis",
  linkedin_url: "https://www.linkedin.com/in/jamis-buck/",
  twitter_url: "https://twitter.com/jamis",
  image: Rails.root.join("#{image_path}/j-buck.jpg").open
)

jenny_shen_speaker = Speaker.create!(
  name: "Jenny Shen",
  job_title: "Senior Developer, Shopify",
  bio: "Jenny is a Senior Developer at Shopify, based in Toronto, Canada. She is a RubyGems.org maintainer, and is passionate about open source.",
  github_url: "https://github.com/jenshenny",
  linkedin_url: "https://www.linkedin.com/in/jenny-shen-/",
  twitter_url: "https://twitter.com/jenshenny",
  image: Rails.root.join("#{image_path}/j-shen.jpg").open
)

julia_lopez_speaker = Speaker.create!(
  name: "Julia López",
  job_title: "Senior Software Engineer, Harvest",
  bio: "I am Julia López and I’ve been working with Rails for over a decade! Currently, I am working as a Senior Software Engineer at Harvest, where we navigate the intricacies of maintaining and enhancing a 17-year-old Rails application. After the conference talks, you can find me at the Karaoke events!",
  github_url: "https://github.com/yukideluxe",
  linkedin_url: "https://www.linkedin.com/in/julialopez/",
  twitter_url: "https://twitter.com/yukideluxe",
  image: Rails.root.join("#{image_path}/j-lopez.png").open
)

justin_searls_speaker = Speaker.create!(
  name: "Justin Searls",
  job_title: "Co-founder, Test Double",
  bio: "Justin is a co-founder Test Double, a consulting agency on a mission to improve how the world builds software. His one gift as a programmer is his ability to cause software to fail. (Which, it turns out, is a surprisingly handy tool in figuring out how to fix it.)",
  github_url: "https://github.com/searls",
  linkedin_url: "https://linkedin.com/in/searls",
  twitter_url: "https://twitter.com/searls",
  image: Rails.root.join("#{image_path}/j-searls.jpg").open
)

kevin_mcconnell_speaker = Speaker.create!(
  name: "Kevin McConnell",
  job_title: "Lead Programmer, 37signals",
  bio: "Kevin is a programmer at 37signals, where he writes a lot of Ruby, and sometimes a bit of Go. When he’s not doing that, he enjoys making electronic music and hiking.",
  github_url: "https://github.com/kevinmcconnell",
  linkedin_url: "",
  twitter_url: "",
  image: Rails.root.join("#{image_path}/k-mcconnell.jpg").open
)

miles_mcguire_speaker = Speaker.create!(
  name: "Miles McGuire",
  job_title: "Staff Engineer, Intercom",
  bio: "Miles has spent 7 years at Intercom working on datastore performance, scalability, and availability from the application layer all the way down.",
  github_url: "https://github.com/minuteman3",
  linkedin_url: "https://www.linkedin.com/in/milesmcguire/",
  twitter_url: "https://twitter.com/_minuteman3",
  image: Rails.root.join("#{image_path}/m-mcguire.jpg").open
)

mostafa_abdelraouf_speaker = Speaker.create!(
  name: "Mostafa Abdelraouf",
  job_title: "Infrastructure Engineer, Instacart",
  bio: "Mostafa is a Senior Staff Software Engineer on the Infrastructure team at Instacart his focus is on the data access layer between Rails and Postgres, he also contributes to PgCat (A PostgreSQL connection pool written in Rust).",
  github_url: "",
  linkedin_url: "",
  twitter_url: "",
  image: Rails.root.join("#{image_path}/m-abdelraouf.jpg").open
)

obie_fernandez_speaker = Speaker.create!(
  name: "Obie Fernandez",
  job_title: "Author of The Rails Way, and Chief Scientist, Olympia",
  bio: "With 30 years in tech and 2 decades in Ruby, Obie, author of “The Rails Way,” is a pivotal and well-loved figure. As co-founder and sole engineer of Olympia, a Rails-based AI startup, he exemplifies building scalable applications with the “One Person Framework”.",
  github_url: "https://github.com/obie",
  linkedin_url: "https://www.linkedin.com/in/obiefernandez/",
  twitter_url: "https://twitter.com/obie",
  image: Rails.root.join("#{image_path}/o-fernandez.jpg").open
)

ridhwana_khan_speaker = Speaker.create!(
  name: "Ridhwana Khan",
  job_title: "Lead Software Engineer & Writer",
  bio: "Ridhwana Khan is a Lead Engineer, an entrepreneur, and a technical writer for the Ruby on Rails Guides. She is driven by the satisfaction of building systems that positively impact people’s lives. She enjoys mentoring, speaking at conferences, and community building.",
  github_url: "https://github.com/ridhwana",
  linkedin_url: "https://www.linkedin.com/in/ridhwanakhan/",
  twitter_url: "https://twitter.com/Ridhwana_K",
  image: Rails.root.join("#{image_path}/r-khan.jpg").open
)

robby_russell_speaker = Speaker.create!(
  name: "Robby Russell",
  job_title: "CEO, Planet Argon",
  bio: "Co-founder of Planet Argon, Host of Maintainable Software Podcast, and Creator of Oh My Zsh.",
  github_url: "https://github.com/robbyrussell",
  linkedin_url: "https://www.linkedin.com/in/robbyrussell/",
  twitter_url: "https://twitter.com/robbyrussell",
  image: Rails.root.join("#{image_path}/r-russell.jpg").open
)

robert_beene_speaker = Speaker.create!(
  name: "Robert Beene",
  job_title: "Founder, Typecraft",
  bio: "Robert has been working with Rails for nearly 20 years, helping clients deliver solutions in the healthcare space. When I’m not building apps with my team, I’m raising three kids in the heart of NYC.",
  github_url: "https://github.com/typecraft-dev/",
  linkedin_url: "https://www.linkedin.com/company/typecraft-dev/",
  twitter_url: "https://x.com/typecraftHQ",
  image: Rails.root.join("#{image_path}/r-beene.jpg").open
)

rosa_gutierrez_speaker = Speaker.create!(
  name: "Rosa Gutierrez",
  job_title: "Principal programmer, 37signals",
  bio: "European. Loves cities, mathematics, theoretical computer science, learning languages for humans and computers, puzzles & bicycles. Human to Mochi.",
  github_url: "https://github.com/rosa",
  linkedin_url: "https://www.linkedin.com/in/rosagutierrezescudero/",
  twitter_url: "https://twitter.com/rosapolis",
  image: Rails.root.join("#{image_path}/r-gutierrez.jpg").open
)

stephen_margheim_speaker = Speaker.create!(
  name: "Stephen Margheim",
  job_title: "Rubyist, Web Developer, and Engineering Manager, Test IO",
  bio: "Hey, I’m Stephen. I’m an American expat living in Berlin with my wife and two dogs. I am a contributor to Rails and the sqlite3-ruby gem as well as the maintainer of a handful of gems aimed at making Ruby and Rails the absolute best platforms in the world to run SQLite projects.",
  github_url: "https://github.com/fractaledmind",
  linkedin_url: "https://www.linkedin.com/in/stephen-margheim-5aa25bb8/",
  twitter_url: "https://twitter.com/fractaledmind",
  image: Rails.root.join("#{image_path}/s-margheim.png").open
)

# Create Sessions

Session.create!(
  conference: conference,
  title: "Opening Keynote",
  description: "DHH will kick off the second edition of Rails World in Toronto with an Opening Keynote highlighting what is new in Rails today, and where the framework is headed tomorrow.",
  starts_at: Time.zone.local(2024, month, start_day, 9, 45),
  ends_at: Time.zone.local(2024, month, start_day, 11, 0),
  location: track_1,
  speakers: [david_heinemeier_hansson_speaker]
)

Session.create!(
  conference: conference,
  title: "Solid Queue internals, externals and all the things in between",
  description: "We’ve used Resque and Redis to run background jobs in multiple apps for many years at 37signals. However, performance, reliability, and our own apps’ idiosyncrasies led us to use a lot of different gems, some developed by us, some forked or patched to address our struggles. After multiple war stories with background jobs, looking at our increasingly complex setup, we wanted something we could use out-of-the-box without having to port our collection of hacks to every new app and with fewer moving pieces. After exploring existing alternatives, we decided to build our own and aim to make it the default for Rails 8. In this talk, I’ll present Solid Queue, explain some of the problems we had over the years, how we designed Solid Queue to address them, and all the Fun™ we had doing that.",
  starts_at: Time.zone.local(2024, month, start_day, 11, 15),
  ends_at: Time.zone.local(2024, month, start_day, 11, 45),
  location: track_1,
  speakers: [rosa_gutierrez_speaker]
)

Session.create!(
  conference: conference,
  title: "Going beyond a Single Postgres Instance with Rails",
  description: "We’ll look at the journey of evolving Instacart’s Rails application beyond a single Postgres instance, how we managed the added complexity from adding read replicas, and later vertically and horizontally sharding. We’ll touch on some topics around query routing, connection pooling and load balancing.",
  starts_at: Time.zone.local(2024, month, start_day, 11, 15),
  ends_at: Time.zone.local(2024, month, start_day, 11, 45),
  location: track_2,
  speakers: [mostafa_abdelraouf_speaker]
)

Session.create!(
  conference: conference,
  title: "The Modern Programmer’s Guide to Neovim and Zellij",
  description: "", # TODO: add description
  starts_at: Time.zone.local(2024, month, start_day, 13, 0),
  ends_at: Time.zone.local(2024, month, start_day, 14, 15),
  location: lightning_track,
  speakers: [chris_power_speaker, robert_beene_speaker]
)

Session.create!(
  conference: conference,
  title: "Kamal 2.0 - Deploy web apps anywhere",
  description: "Kamal is an imperative deployment tool from 37signals for running your apps with Docker. We’ll run through how it works, what we’ve learned from v1.0, and the changes we’ve made for v2.0.",
  starts_at: Time.zone.local(2024, month, start_day, 13, 0),
  ends_at: Time.zone.local(2024, month, start_day, 13, 30),
  location: track_1,
  speakers: [donal_mcbreen_speaker]
)

Session.create!(
  conference: conference,
  title: "Repurposing the Rails CLI",
  description: "The Rails CLI works great for the vast majority of us, but what do you do when it doesn’t? At MongoDB, we recently wanted to add a tighter integration between Rails and Mongoid (our ODM), and were able to create our own CLI tool that extends the Rails CLI, overriding the pieces that weren’t compatible or relevant and extending it with the functionality we wanted. I’ll show you how we did it, and how you can do it yourself.",
  starts_at: Time.zone.local(2024, month, start_day, 13, 0),
  ends_at: Time.zone.local(2024, month, start_day, 13, 30),
  location: track_2,
  speakers: [jamis_buck_speaker]
)
Session.create!(
  conference: conference,
  title: "Introducing Kamal Proxy",
  description: "Kamal Proxy is a new, purpose-built HTTP proxy service that powers Kamal 2.0. It’s designed to make zero-downtime deployments simpler, and comes with additional features to make your Rails applications faster and easier to operate. In this talk, we’ll look at what Kamal Proxy does, why we built it, and how it works.",
  starts_at: Time.zone.local(2024, month, start_day, 13, 45),
  ends_at: Time.zone.local(2024, month, start_day, 14, 15),
  location: track_1,
  speakers: [kevin_mcconnell_speaker]
)

Session.create!(
  conference: conference,
  title: "The state of security in Rails 8",
  description: "Security is a crucial aspect of any web application and Rails is one of the best options for an application with high security standards. In this talk, I will highlight the recent security related improvements in Rails.",
  starts_at: Time.zone.local(2024, month, start_day, 13, 45),
  ends_at: Time.zone.local(2024, month, start_day, 14, 15),
  location: track_2,
  speakers: [greg_molnar_speaker]
)

Session.create!(
  conference: conference,
  title: "An upgrade handbook to Rails 8",
  description: "Each new major version of Rails unlocks so many great features, and Rails 8 is no exception. However, upgrading a Rails application can be difficult. This talk will look at ways to address the major changes for Rails 8 to get your Rails app prepared to run on the latest version in no time! We’ll also explore how Shopify was able to automate the Rails upgrade process for hundreds of their applications.",
  starts_at: Time.zone.local(2024, month, start_day, 14, 45),
  ends_at: Time.zone.local(2024, month, start_day, 15, 15),
  location: track_1,
  speakers: [jenny_shen_speaker]
)

Session.create!(
  conference: conference,
  title: "The Empowered Programmer",
  description: "In 2021, DHH dubbed Rails, 'The One Person Framework.' Is it? This talk will explore how Rails 7 equips solo developers more than ever before. Drawing from personal experience, I'll share how building a new app with Rails 7 felt like half the work of my previous Rails 5 project. You'll learn about the benefits of sticking with omakase, how Rails includes more batteries than ever, and why scaling back a team doesn't have to mean slowing down.",
  starts_at: Time.zone.local(2024, month, start_day, 14, 45),
  ends_at: Time.zone.local(2024, month, start_day, 15, 15),
  location: track_2,
  speakers: [justin_searls_speaker]
)

Session.create!(
  conference: conference,
  title: "Frontiers of development productivity in Rails",
  description: "Rails is known to be one of the best frameworks in terms of empowering developers to build great products, and has kept this place for 20 years. Can we do better? In this talk, we will see how we are pushing Rails to continue making developers lives easier in new frontiers.",
  starts_at: Time.zone.local(2024, month, start_day, 15, 45),
  ends_at: Time.zone.local(2024, month, start_day, 16, 15),
  location: track_1,
  speakers: [rafael_franca_speaker]
)

Session.create!(
  conference: conference,
  title: "Progressive Web Apps for Rails developers",
  description: "Explore the evolving world of Progressive Web Apps (PWAs), built with familiar Rails technologies and designed for seamless use in all compatible browsers. Rails 8 promises to simplify PWA development, offering innovative methods to swiftly generate essential PWA scaffolding. This talk covers PWA basics, their inner workings, and Rails 8’s crucial development role. We’ll examine service worker lifecycle, offline strategies via background sync, and the CacheStorage API for cross-device performance. Additionally, we’ll investigate local data storage via IndexDB and exploiting Push Notifications to elevate the user experience to that of native applications.",
  starts_at: Time.zone.local(2024, month, start_day, 15, 45),
  ends_at: Time.zone.local(2024, month, start_day, 16, 15),
  location: track_2,
  speakers: [emmanuel_hayford_speaker]
)

Session.create!(
  conference: conference,
  title: "Matz & DHH Fireside chat, hosted by Tobias Lütke",
  description: "We are pleased to welcome Ruby creator and special guest Yukihiro Matsumoto (Matz) to the Rails World stage for a fireside chat with Rails creator David Heinemeier Hansson (DHH). Together on stage for the very first time! Hosted by Shopify founder Tobias Lütke, this is sure to be a conversation you don’t want to miss.",
  starts_at: Time.zone.local(2024, month, start_day, 16, 30),
  ends_at: Time.zone.local(2024, month, start_day, 17, 30),
  location: track_1,
  speakers: [matz_speaker, david_heinemeier_hansson_speaker, tobias_luetke_speaker]
)

Session.create!(
  conference: conference,
  title: "Opening Keynote",
  description: "More information coming soon.",
  starts_at: Time.zone.local(2024, month, second_day, 10, 0),
  ends_at: Time.zone.local(2024, month, second_day, 11, 0),
  location: track_1,
  speakers: [eileen_uchitelle_speaker]
)

Session.create!(
  conference: conference,
  title: "SQLite on Rails - Busting myths and supercharging the One-Person Framework",
  description: "Rails 8 takes the 'one-person framework' to new heights. Enhancements to the SQLite adapter and the suite of Solid libraries now cement its standing as the top choice for solo developers and small teams. This talk will bust myths with benchmarks, showcase scalability with case studies, and sidestep pitfalls with practical tips. Concrete, real-world examples will illustrate how the Rails 8 feature set perfectly complements SQLite’s power in creating resilient, high-performance production apps. You’ll leave with a solid understanding of when SQLite does and doesn’t make sense for your application and how to leverage Rails and SQLite’s full potential in your next production venture.",
  starts_at: Time.zone.local(2024, month, second_day, 11, 15),
  ends_at: Time.zone.local(2024, month, second_day, 11, 45),
  location: track_1,
  speakers: [stephen_margheim_speaker]
)

Session.create!(
  conference: conference,
  title: "Demystifying some of the magic behind Rails",
  description: "Rails is renowned for its elegance, productivity, and 'magic' that simplifies web development. As a recent technical writer for the official Ruby on Rails guides, I’ve had the opportunity to dive into the 'magic' of Rails to enhance my understanding of the source code and provide clear explanations in the guides. In this talk, I’ll share my journey of inspecting modules, exploring concepts, and sharing insights gained from my experience to help attendees better understand how some Rails components work internally. Whether you are a beginner eager to understand the framework’s foundations or an experienced developer looking to deepen your knowledge, this dive into the source code will enhance your proficiency and demystify the framework’s inner workings.",
  starts_at: Time.zone.local(2024, month, second_day, 11, 15),
  ends_at: Time.zone.local(2024, month, second_day, 11, 45),
  location: track_2,
  speakers: [ridhwana_khan_speaker]
)

Session.create!(
  conference: conference,
  title: "Making the best of a bad situation - Lessons from one of Intercom’s most painful outages",
  description: "On 22 Feb 2024 Intercom had one of its most painful outages in recent memory. The root cause? A 32-bit foreign key referencing a 64-bit primary key. We’ll take a look at what happened, why it happened, and what we did to ensure it didn’t happen again, including some changes you can make to your own Rails apps to help make sure you don’t make the same mistakes.",
  starts_at: Time.zone.local(2024, month, second_day, 13, 0),
  ends_at: Time.zone.local(2024, month, second_day, 13, 30),
  location: track_1,
  speakers: [miles_mcguire_speaker]
)

Session.create!(
  conference: conference,
  title: "Pushing the boundaries with ActiveStorage",
  description: "In this talk you’ll learn how to push the boundaries with ActiveStorage and leverage it to build feature rich user experiences. You’ll learn how to build custom services to integrate with external providers that go above and beyond the built in services to allow users to select images from a third party API that hosts images for you, and a rich media library that allows users to see, modify and upload files they’ve uploaded that can be selected from in forms in place of uploading a new file.",
  starts_at: Time.zone.local(2024, month, second_day, 13, 0),
  ends_at: Time.zone.local(2024, month, second_day, 13, 30),
  location: track_2,
  speakers: [andrea_fomera_speaker]
)

Session.create!(
  conference: conference,
  title: "Making accessible web apps with Rails and Hotwire",
  description: "Nowadays, there is a lot of talk about accessibility, but is your web app accessible? In this session, I will share my perspective as a blind developer on how to build accessible web apps with real-world examples, beyond saying it’s important and the need to use ARIA. I will start by demonstrating how a blind person uses a screen reader to navigate the web, so that you can understand the most common challenges faced by blind people every day. This will help clarify several requirements that people currently spend too much time on. Instead, we can focus on the most relevant errors and aspects to bear in mind when developing and designing interfaces. We will cover the most common patterns with code examples, taking advantage of tools provided by Rails, Hotwire, and the browser.",
  starts_at: Time.zone.local(2024, month, second_day, 13, 45),
  ends_at: Time.zone.local(2024, month, second_day, 14, 15),
  location: track_1,
  speakers: [bruno_prieto_speaker]
)

Session.create!(
  conference: conference,
  title: "The Modern Programmer’s Guide to Neovim and Zellij",
  description: "", # TODO: fix description
  starts_at: Time.zone.local(2024, month, second_day, 13, 0),
  ends_at: Time.zone.local(2024, month, second_day, 14, 15),
  location: lightning_track,
  speakers: [chris_power_speaker, robert_beene_speaker]
)

Session.create!(
  conference: conference,
  title: "Prepare to tack - Steering Rails apps out of technical debt",
  description: "Spoiler alert: we’ve been wrong about tech debt. Our Rails apps are drowning in a sea of compromises and quick fixes, making it difficult to update and slowing us down. It’s high time we redefine “technical debt” — perhaps even time to ditch the term altogether. In this talk, we’re not only exploring the common issues facing our Rails apps; we’re going deeper. We’ll uncover roadblocks, blind spots, and comfort zones that lead us to rationalize away the need for necessary changes. By confronting these excuses head-on, we’re not just aiming to fix immediate problems; we’re working towards a more maintainable, efficient codebase. Whether you’re part of a duo or sailing with a crew of several dozen, this session charts a course for tackling what truly matters. It’s time to grab the wheel.",
  starts_at: Time.zone.local(2024, month, second_day, 13, 45),
  ends_at: Time.zone.local(2024, month, second_day, 14, 15),
  location: track_2,
  speakers: [robby_russell_speaker]
)

Session.create!(
  conference: conference,
  title: "The Rails Boot Process",
  description: "In this talk we’ll cover what happens when a Rails application boots. When is the logger ready? When is $LOAD_PATH set? When do initializers run or when are the autoloaders set up? Basically, we’ll understand what runs when. Also, we’ll understand railties and engines initializers, which are key to this process.",
  starts_at: Time.zone.local(2024, month, second_day, 14, 45),
  ends_at: Time.zone.local(2024, month, second_day, 15, 15),
  location: track_1,
  speakers: [xavier_noria_speaker]
)

Session.create!(
  conference: conference,
  title: "Testing Integrations - The Good, the Bad, and the Ugly",
  description: "Does your Rails app have integrations with third-party APIs? Perhaps your billing system relies on a subscription management tool, or you utilize email marketing applications to engage customers? Enhancing your features through external tools can be powerful, but testing these integrations could pose challenges or be cumbersome. Join me as we explore practical strategies for testing integrations, drawing from real-life experiences at Harvest, where we implemented several integrations – Braintree, Stripe, CustomerIO, Hubspot, Xero, QuickBooks, and more – and gain confidence in safeguarding your codebase during refactorings or API version changes.",
  starts_at: Time.zone.local(2024, month, second_day, 14, 45),
  ends_at: Time.zone.local(2024, month, second_day, 15, 15),
  location: track_2,
  speakers: [julia_lopez_speaker]
)

Session.create!(
  conference: conference,
  title: "Empowering the Individual - Rails on AI",
  description: "The dream of the “One Person Framework” is more tangible than ever. Integrating AI with Ruby on Rails can transform a solo developer’s workflow into an incredibly potent force, capable of competing at an unprecedented scale. This presentation draws on practical real-world experience. We will explore practical approaches ranging from code generation to real-time data analysis and automated customer support. The emphasis is on new tools that let developers focus more than ever on innovation and creativity. Attendees will leave with a roadmap for integrating AI tools and techniques into their Rails projects, insights into the potential pitfalls and best practices, and inspiration to explore the boundaries of what a single developer or a small team can achieve with the right tools.",
  starts_at: Time.zone.local(2024, month, second_day, 15, 45),
  ends_at: Time.zone.local(2024, month, second_day, 16, 15),
  location: track_1,
  speakers: [obie_fernandez_speaker]
)

Session.create!(
  conference: conference,
  title: "Level up performance with simple coding changes",
  description: "This presentation will first highlight some of the major improvements Zendesk has achieved using straightforward Ruby techniques. Data will illustrate the saving of thousands of years of processing time annually, leading to increased customer satisfaction and cost-effectiveness, as reflected in our AWS bills. Fortunately, many of these enhancements are straightforward to implement from day one. My goal is to show folks how to incorporate these types of improvements early in their development process and share my learnings with the broader community.",
  starts_at: Time.zone.local(2024, month, second_day, 15, 45),
  ends_at: Time.zone.local(2024, month, second_day, 16, 15),
  location: track_2,
  speakers: [david_henner_speaker]
)

Session.create!(
  conference: conference,
  title: "Closing Keynote",
  description: "More information coming soon.",
  starts_at: Time.zone.local(2024, month, second_day, 16, 30),
  ends_at: Time.zone.local(2024, month, second_day, 17, 30),
  location: track_1,
  speakers: [aaron_patterson_speaker]
)

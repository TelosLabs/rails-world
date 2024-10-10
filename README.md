# Rails World Conference App

Rails application that allows you to create and manage conferences. You can use it to create a conference, add speakers and sessions. Attendees can register for the conference, view the schedule, receive notifications and more.

## Installation

1. Requirements
  - Ruby 3.3.x (https://www.ruby-lang.org/en/documentation/installation/)
  - Bundler (`gem install bundler`)
2. Clone the repository (`git clone xxx`)
3. Run `bin/setup` (needs to be run only once)
4. Run `bin/dev`
5. Visit `http://localhost:3000` in your browser

## The stack

- Ruby on Rails 7.2.x
- Ruby 3.3.x
- SQLite3
- SolidQueue
- Hotwire
- Import maps
- Tailwind CSS

## Usage

1. Visit `http://localhost:3000/avo`
2. Log in as an admin (see `config/seeds.rb` for the default admin credentials)
3. In avo, you can create a new conference, add speakers, locations and sessions
4. Visit `http://localhost:3000` to see the conference schedule

#### Feature Flags

You can enable features by using ENV variables. The ENV var key should follow the convention "#{feature_name}_ENABLED". For example, to enable the `litestream_backups` feature, add `LITESTREAM_BACKUP_ENABLED="true"` to your .env file. You can view all the available features in `app/models/feature.rb`.

## Deployment

The application is configured to be deployed using [Kamal](https://kamal-deploy.org/). Each env has its own deploy.yml file, which should be updated with the correct values for your environment. Also, remember to create a .env file per environment (e.g. .env.production) with the correct values.

#### Dependencies

- AppSignal for monitoring
- AWS S3 for file storage & backups
- MailPace for sending emails

## Contributing

### Linting & Formatting

#### Ruby

We use [Standard Ruby](https://github.com/standardrb/standard) for linting and formatting.
- Run `bundle exec rubocop` to check all ruby files
- Run `bundle exec rubocop -a` to auto-correct offenses
- [How do I run RuboCop in my editor?](https://docs.rubocop.org/rubocop/1.25/integration_with_other_tools.html#editor-integration)

#### ERB

We use [ERB Lint](https://github.com/Shopify/erb-lint) to lint our ERB files.
- Run `bundle exec erblint --lint-all` to check all ERB files
- Run `bundle exec erblint --lint-all -a` to auto-correct offenses. WARNING: This command isn't safe and can break your code.

#### JavaScript

We use [StandardJS](https://standardjs.com/) to lint our JavaScript files.
- Install by running `npm install standard --global`
- Run `standard` to check all JavaScript files
- Run `standard --fix` to auto-correct offenses
- [How do I run StandardJS in my editor?](https://standardjs.com/#are-there-text-editor-plugins)
- [How do I make the output more readable?](https://github.com/standard/standard?tab=readme-ov-file#how-do-i-make-the-output-all-colorful-and-pretty)

#### Spelling

We use [Typos](https://github.com/crate-ci/typos) as a spell checker.
- Install by running `brew install typos-cli`
- Run `typos` to check all files
- Run `typos -w` to auto-correct offenses
- For false positives and other configuration, see the `_typos.yml` file

#### Optional - Running linters' auto-fix before a commit

[Leftook](https://github.com/evilmartians/lefthook) will execute the linters' auto-fix on staged files and abort the commit if there are offenses that can't be auto-fixed.
Run the following commands to enable this flow:

```
gem install lefthook
lefthook install
```

### Code Quality

#### Rubycritic

Besides code reviews, we use [rubycritic](https://github.com/whitesmith/rubycritic) to generate a report of the code quality. Both as a reviewer and as a contributor, you should check the report and address the issues found if the files you are working on have a low score ("D" or "F").
- You can run it with `bundle exec rubycritic`

#### Database consistency

We use [DatabaseConsistency](https://github.com/djezzzl/database_consistency) to check for inconsistencies between the database schema and the application models.
- You can run it with `bundle exec database_consistency`.

### Testing

Run tests by using `bundle exec rspec`.

#### System specs

- Headless is the default config. If you want to see the browser you can run the following command: `HEADLESS=false bundle exec rspec`
- If you want to pause the execution you can use `pause` inside an `it` statement.
- If you want to see the logs you can use `:log`, e.g. `it "xxx", :log do`
- Use `data-test-id` to find elements instead of classes/ids, e.g. `data-test-id="decline_modal"`
- Use the methods in the `DataTestId` module to select HTML elements, e.g., `find_dti("decline_modal")`

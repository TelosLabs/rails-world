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

- Ruby on Rails 8.0
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

You can enable features by using ENV variables. The ENV var key should follow the convention "#{feature_name}_ENABLED". For example, to enable the `litestream_backups` feature, add `LITESTREAM_BACKUP_ENABLED=true` to your .env file. You can view all the available features in `app/models/feature.rb`.

## Deployment

This application is set up for deployment using [Kamal 2](https://kamal-deploy.org/).

Each environment has its own deploy.yml file. Before you deploy, check that these files have the correct values for your environment. If you have already run `bin/setup`, there should be a .env file for each environment. Just fill in the required variables!

### Staging Deployment

The staging environment can be used for QA before deploying a new version to production.

<details>
<summary>Your First Staging Deployment</summary>
Currently, the staging environment is set up to use AppSignal, MailPace, Avo, and local storage for files.

Make sure all your environment variables are present in the `.env.staging` file. Kamal only loads variables from your shell environment (ENV), not from dotenv `.env` files [as discussed here](https://github.com/basecamp/kamal/discussions/977).

You can use the `dotenv` command before Kamal commands to load variables from your `.env.staging` file. Check if all variables are present with:

```bash
dotenv -f ".env.staging" kamal secrets print -d staging
```

When all variables are present, you can deploy. **Important!**: You must commit your changes before Kamal picks them up.

```bash
dotenv -f ".env.staging" kamal deploy -d staging
```
</details>


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

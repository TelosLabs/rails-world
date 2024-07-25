# Rails World

[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)

## About

- Ruby on Rails 7.1.x
- Ruby 3.3.x
- SQLite3
- SolidQueue
- Hotwire
- Import maps
- Tailwind CSS
- Kamal

## Running the application

1. Run `bin/setup` (needs to be run only once)
2. Run `bin/dev`

or

1. Run `docker compose up`

## Linting & Formatting

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

## Code Quality

#### Rubycritic

Besides code reviews, we use [rubycritic](https://github.com/whitesmith/rubycritic) to generate a report of the code quality. Both as a reviewer and as a contributor, you should check the report and address the issues found if the files you are working on have a low score ("D" or "F").
- You can run it with `bundle exec rubycritic`

#### Database consistency

We use [DatabaseConsistency](https://github.com/djezzzl/database_consistency) to check for inconsistencies between the database schema and the application models.
- You can run it with `bundle exec database_consistency`.

## Testing

Run tests by using `bundle exec rspec`.

#### System specs

- Headless is the default config. If you want to see the browser you can run the following command: `HEADLESS=false bundle exec rspec`
- If you want to pause the execution you can use `pause` inside an `it` statement.
- If you want to see the logs you can use `:log`, e.g. `it "xxx", :log do`
- Use `data-test-id` to find elements instead of classes/ids, e.g. `data-test-id="decline_modal"`
- Use the methods in the `DataTestId` module to select HTML elements, e.g., `find_dti("decline_modal")`

## DevOps

The staging link is [http://10.118.0.2/](http://10.118.0.2/) and the production link is TBD.

#### Deployment

We use Kamal to deploy the application. Here are some common commands:

- Run `kamal deploy` to deploy the application.
- Run `kamal env push` to push the environment variables to the application.
- Run `kamal app exec -i 'bin/rails console'` to open a Rails console.

You need to append `-d staging` or `-d production` to the command to specify the environment.

#### Tools

- Kamal is used to deploy the application.
- DigitalOcean is used to host the application.
- AppSignal is used for monitoring the application.
- Cloudflare is used as a CDN.
- Litestream is used for database backups.
- MailPace is used for transactional emails.

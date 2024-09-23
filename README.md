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

## Running the application

1. Run `bin/setup` (needs to be run only once)
2. Run `bin/dev`

or

1. Run `docker compose up`

## Customization

### General App Colors

To customize the general app colors, modify the `tailwind.config.js` file. Specifically, update the `primary` and `secondary` colors under the `theme.extend.colors` section.

```javascript
module.exports = {
  theme: {
    extend: {
      colors: {
        primary: {
          500: '#your_primary_color_code',
        },
        secondary: {
          500: '#your_secondary_color_code',
        },
      },
    },
  },
};
```

> 404, 406, 422 and 500 error pages need to be updated manually. You can find them in the `/public` folder.

### Input Fields

If you change the general app colors, you may also need to update the input fields' styles. Modify the `STYLES` hash in the form builder located at `/app/builders/application_form_builder.rb` as follows:

```ruby
STYLES = {
  default: "bg-transparent border border-2 border-white rounded-md text-white
  placeholder-white/50 focus:bg-white focus:text-black focus:placeholder-gray
  focus:border-white focus:ring-white transition-all",
  toggle_field: "relative w-11 h-6 bg-gray-6 rounded-full peer dark:bg-gray-6
  peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full
  peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px]
  after:start-[2px] after:bg-white after:rounded-full after:h-5 after:w-5
  after:transition-all peer-checked:bg-secondary-500 cursor-pointer",
  error_message: "text-red text-sm",
  label: "font-bold text-base"
}.freeze
```

Additionally, update the error field styles in `application.tailwind.css`:

```css
div.field_with_errors > label {
  @apply mb-2 italic font-bold text-red;
}

div.field_with_errors > input {
  @apply w-full bg-transparent border-2 border-red
  rounded-md text-white placeholder:text-white/50
  focus:bg-white focus:text-black focus:placeholder-gray
  focus:border-white focus:ring-white mb-2;
}
```

### Logos and images

To customize the logos and images you can replace the following files located in the `/app/assets/images`:

- `logo.svg` used in the header of the page
- `logo.png` used in the footer of the mailers
- `main_logo.svg` used in the login and coming soon page
- `favicon.svg` used as the favicon
- `home_screen_icon.png` used as the home screen icon for PWA installations
- `splashscreen_icon.png` used as the splash screen icon for PWA loading screens
- `/public/pwa_home_screen_icon.png` used as the icon for PWA notifications
> iOS splashsreens are located here: `/app/assets/images/splashscreens`

### PWA Configuration

To customize the app name in PWA installations, update the manifest configuration file: `app/views/service_worker/manifest.json.erb`

```json
{
  "name": "Rails World",
  "short_name": "Rails World",
  ...
}
```

### App Notifications

Session reminder notifications (web-push and email) are defaulted to 10 minutes before the session begins.
You can customize this time by updating the `REMINDER_TIME_BEFORE_EVENT` constant in: `app/jobs/session_reminder_job.rb`

### Time zone

The default time zone is set to `UTC`. You can change this by updating the `TIME_ZONE` in the `.env` file.

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

## Feature Flags

Use ENV variables to enable features, the name should follow the convention `"#{feature_name}_ENABLED"`. For example, to enable the `payment` feature, use `ENV["PAYMENT_ENABLED"]="true"`.

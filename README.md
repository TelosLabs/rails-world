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

## Testing

Run tests by using `bundle exec rspec`.

#### System specs

- Headless is the default config. If you want to see the browser you can run the following command: `HEADLESS=false bundle exec rspec`
- If you want to pause the execution you can use `pause` inside an `it` statement.
- If you want to see the logs you can use `:log`, e.g. `it "xxx", :log do`
- Use `data-test-id` to find elements instead of classes/ids, e.g. `data-test-id="decline_modal"`
- Use the methods in the `DataTestId` module to select HTML elements, e.g., `find_dti("decline_modal")`

module BetterRailsSystemTests
  # Make failure screenshots compatible with multi-session setup.
  def take_screenshot
    return super unless Capybara.last_used_session

    Capybara.using_session(Capybara.last_used_session) { super }
  end
end

RSpec.configure do |config|
  config.include BetterRailsSystemTests, type: :system

  # Make urls in mailers contain the correct server host.
  # This is required for testing links in emails (e.g., via capybara-email).
  config.around(:each, type: :system) do |ex|
    was_host = Rails.application.default_url_options[:host]
    Rails.application.default_url_options[:host] = Capybara.server_host
    ex.run
    Rails.application.default_url_options[:host] = was_host
  end

  # Make sure this hook runs before others
  config.prepend_before(:each, type: :system) do
    WebMock.disable_net_connect!(
      allow: [
        "localhost",
        "127.0.0.1",
        "opensearch",
        %r{chromedriver.storage.googleapis.com/.*}
      ]
    )
    # Use JS driver always
    driven_by Capybara.javascript_driver
  end
end

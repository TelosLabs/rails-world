class ConfigurationsController < ApplicationController
  skip_before_action :authenticate_user!

  def ios
    render json: {
      settings: {},
      rules: [
        {
          patterns: [
            ".*"
          ],
          properties: {
            context: "default",
            pull_to_refresh_enabled: true
          }
        },
        {
          patterns: [
            "/edit$",
            "/registration/new$",
            "/password_reset/new$"
          ],
          properties: {
            context: "modal",
            pull_to_refresh_enabled: false
          }
        },
        {
          patterns: [turbo_recede_historical_location_url],
          properties: {presentation: "pop"}
        },
        {
          patterns: [turbo_resume_historical_location_url],
          properties: {presentation: "none"}
        },
        {
          patterns: [turbo_refresh_historical_location_url],
          properties: {presentation: "refresh"}
        }
      ]
    }
  end

  def android
    render json: {
      settings: {},
      rules: [
        {
          patterns: [
            ".*"
          ],
          properties: {
            uri: "hotwire://fragment/web",
            pull_to_refresh_enabled: true
          }
        },
        {
          patterns: [
            "/edit$",
            "/registration/new$",
            "/password_reset/new$"
          ],
          properties: {
            context: "modal",
            uri: "hotwire://fragment/web/modal/sheet",
            pull_to_refresh_enabled: false
          }
        }
      ]
    }
  end
end

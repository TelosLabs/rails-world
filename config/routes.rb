Rails.application.routes.draw do
  get "up" => "rails/health#show", :as => :rails_health_check

  # TODO: authenticate with admin user
  mount MissionControl::Jobs::Engine, at: "/jobs"

  root "main#index"

  resource :registration, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resource :password, only: [:edit, :update]
  resource :password_reset, only: [:new, :create, :edit, :update]

  resource :profile, only: [:edit, :update, :show]
  resource :preview_profile, only: [:show]

  resources :events, only: [:index, :show]
end

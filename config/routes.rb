Rails.application.routes.draw do
  root "main#index"

  get "up" => "rails/health#show", :as => :rails_health_check

  # TODO: authenticate with admin user
  mount MissionControl::Jobs::Engine, at: "/jobs"
  mount Avo::Engine, at: Avo.configuration.root_path

  resource :registration, only: [:new, :create]
  resource :user_session, only: [:new, :create, :destroy]
  resource :password, only: [:edit, :update]
  resources :speakers, only: [:show]
  resources :sessions, only: [:index, :show]
  resource :password_reset, only: [:new, :create, :edit, :update] do
    get :post_submit
  end
  resource :about, only: [:show]
  resource :web_push_subscription, only: [:create]
  resource :notification_settings, only: [:show, :update]

  resources :profiles, only: [:show, :edit, :update], param: :uuid
  resources :notifications, only: [:index]
end

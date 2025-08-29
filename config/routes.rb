Rails.application.routes.draw do
  constraints AuthenticatedConstraint.new do
    root "sessions#index"
  end

  constraints UnauthenticatedConstraint.new do
    root "user_sessions#new", as: :unauthenticated_root
  end

  get "up" => "rails/health#show", :as => :rails_health_check
  get "/service-worker.js" => "service_worker#service_worker"
  get "/offline.html" => "service_worker#offline"
  get "/manifest.json" => "service_worker#manifest"
  get "/privacy_policy", to: "static_pages#privacy_policy"
  get "/account_deletion", to: "static_pages#account_deletion"
  get "/about", to: "static_pages#about"
  get "/profile", to: "profiles#show", as: :profile_root

  mount MissionControl::Jobs::Engine, at: "/jobs"
  mount Avo::Engine, at: Avo.configuration.root_path

  resource :registration, only: [:new, :create]
  resource :user_session, only: [:new, :create, :destroy]
  resource :user, only: [:edit, :update]
  resource :password, only: [:edit, :update]
  resource :password_reset, only: [:new, :create, :edit, :update] do
    get :post_submit
  end
  resource :notification_settings, only: [:show, :update]
  resource :coming_soon, only: [:show]
  resource :schedule, only: [:show]

  resources :sessions, only: [:index, :show] do
    resource :attendee, only: [:create, :destroy]
  end
  resources :speakers, only: [:show]
  resources :profiles, only: [:show, :edit, :update, :destroy], param: :uuid
  resources :abuse_reports, only: [:create], param: :uuid
  resources :notifications, only: [:index]
  resources :web_push_subscriptions, only: [:create]

  resources :configurations, only: [] do
    get :ios, on: :collection
    get :android, on: :collection
  end
end

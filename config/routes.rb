Rails.application.routes.draw do
  root "main#index"

  get "up" => "rails/health#show", :as => :rails_health_check
  get "/service-worker.js" => "service_worker#service_worker"
  get "/manifest.json" => "service_worker#manifest"

  mount MissionControl::Jobs::Engine, at: "/jobs"
  mount Avo::Engine, at: Avo.configuration.root_path

  resource :registration, only: [:new, :create]
  resource :user_session, only: [:new, :create, :destroy]
  resource :password, only: [:edit, :update]
  resource :password_reset, only: [:new, :create, :edit, :update] do
    get :post_submit
  end
  resource :about, only: [:show]
  resource :notification_settings, only: [:show, :update]

  resources :profiles, only: [:show, :edit, :update], param: :uuid
  resources :speakers, only: [:show]
  resources :sessions, only: [:index, :show]
  resources :notifications, only: [:index]
  resources :web_push_subscriptions, only: [:create]
end

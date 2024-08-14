Rails.application.routes.draw do
  root "sessions#index"

  get "up" => "rails/health#show", :as => :rails_health_check

  mount MissionControl::Jobs::Engine, at: "/jobs"
  mount Avo::Engine, at: Avo.configuration.root_path

  resource :registration, only: [:new, :create]
  resource :user_session, only: [:new, :create, :destroy]
  resource :password, only: [:edit, :update]
  resource :password_reset, only: [:new, :create, :edit, :update] do
    get :post_submit
  end
  resource :notifications_settings, only: [:show, :update]
  resource :about, only: [:show]
  resource :attendee, only: [:create, :destroy]
  resource :schedule, only: [:index, :update, :show]

  resources :sessions, only: [:index, :update, :show]
  resources :speakers, only: [:show]
  resources :profiles, only: [:show, :edit, :update], param: :uuid
  resources :notifications, only: [:index]

  get "/service-worker.js" => "service_worker#service_worker"
  get "/manifest.json" => "service_worker#manifest"
end

Rails.application.routes.draw do
  root "sessions#index"

  get "up" => "rails/health#show", :as => :rails_health_check

  # TODO: authenticate with admin user
  mount MissionControl::Jobs::Engine, at: "/jobs"
  mount Avo::Engine, at: Avo.configuration.root_path

  resource :registration, only: [:new, :create]
  resource :user_session, only: [:new, :create, :destroy]
  resource :password, only: [:edit, :update]
  resources :speakers, only: [:show]
  resource :password_reset, only: [:new, :create, :edit, :update] do
    get :post_submit
  end
  resources :sessions, only: [:index, :update, :show]
  resources :schedules, only: [:index, :update, :show]
  resources :profiles, only: [:show, :edit, :update], param: :uuid
  resource :about, only: [:show]
end

Rails.application.routes.draw do
  root "main#index"

  get "up" => "rails/health#show", :as => :rails_health_check

  # TODO: authenticate with admin user
  mount MissionControl::Jobs::Engine, at: "/jobs"
  mount Avo::Engine, at: Avo.configuration.root_path

  resource :registration, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resource :password, only: [:edit, :update]
  resource :profile, only: [:edit, :update, :show]
  resources :events, only: [:index, :show]

  resources :speakers, only: [:show]

  resource :password_reset, only: [:new, :create, :edit, :update] do
    get :post_submit
  end
end

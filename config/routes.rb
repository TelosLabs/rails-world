Rails.application.routes.draw do
  constraints(AdminConstraint) do
    mount MissionControl::Jobs::Engine, at: "/jobs"
    mount Avo::Engine, at: Avo.configuration.root_path
  end

  constraints(AuthenticatedConstraint) do
    root "main#index", as: :authenticated_root
    resources :profiles, only: [:edit, :update], param: :uuid
    resources :speakers, only: [:show]
    resources :sessions, only: [:index, :show]
  end

  root "user_sessions#new"

  resource :registration, only: [:new, :create]
  resource :user_session, only: [:new, :create, :destroy]
  resource :password, only: [:edit, :update]
  resource :about, only: [:show]
  resources :profiles, only: [:show], param: :uuid

  resource :password_reset, only: [:new, :create, :edit, :update] do
    get :post_submit
  end

  resource :about, only: [:show]
  resources :profiles, only: [:show], param: :uuid

  get "up" => "rails/health#show", :as => :rails_health_check
  get "/service-worker.js" => "service_worker#service_worker"
  get "/manifest.json" => "service_worker#manifest"
end

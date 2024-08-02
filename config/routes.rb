Rails.application.routes.draw do
  root "main#index"

  get "up" => "rails/health#show", :as => :rails_health_check

  constraints(AdminConstraint) do
    mount MissionControl::Jobs::Engine, at: "/jobs"
    mount Avo::Engine, at: Avo.configuration.root_path
  end

  constraints(AuthenticatedConstraint) do
    resource :password, only: [:edit, :update]
    resources :profiles, only: [:edit, :update], param: :uuid
  end

  resource :registration, only: [:new, :create]
  resource :user_session, only: [:new, :create, :destroy]
  resource :about, only: [:show]
  resources :profiles, only: [:show], param: :uuid

  resource :password_reset, only: [:new, :create, :edit, :update] do
    get :post_submit
  end
end

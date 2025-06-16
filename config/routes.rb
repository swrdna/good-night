Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "api/v1/public/public#index"

  namespace :api do
    namespace :v1 do
      namespace :private do
        resources :users
      end

      namespace :public do
        resources :users, only: :index
      end
    end
  end
end

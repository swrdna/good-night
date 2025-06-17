# frozen_string_literal: true

Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "api/v1/public/public#index"

  namespace :api do
    namespace :v1 do
      namespace :private do
        resources :users do
          resources :sleep_sessions, except: :create
          member do
            resource :clock_in, only: :create, controller: 'clock_in'
            resource :clock_out, only: :update, controller: 'clock_out'

            post "follow/:target_user_id", to: "user_follow#create"
            delete "unfollow/:target_user_id", to: "user_follow#destroy"
          end
        end
      end

      namespace :public do
        resources :users, only: :index do
          member do
            resources :followers, only: :index
            resources :following, only: :index, controller: 'following'
          end
        end
      end
    end
  end
end

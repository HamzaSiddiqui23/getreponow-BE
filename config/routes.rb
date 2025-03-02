# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      post '/login', to: 'authentication#login'

      resources :users, only: %i[index show create update]
      resources :locations, only: %i[index show create update]
      resources :addresses, only: %i[show update]
      resources :contacts, only: %i[index show create update] do
        collection do
          post :upload_csv
        end
      end
    end
  end
end

Rails.application.routes.draw do
  devise_for :users

  # Api definition
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :people
      resources :addresses
      resources :address_types, only: [:index, :show]
      resources :sessions, :only => [:create, :destroy]
    end
  end
end

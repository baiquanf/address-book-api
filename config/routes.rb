Rails.application.routes.draw do
  # Api definition
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :people
      resources :address_types, only: [:index, :show]
      resources :addresses
    end
  end
end

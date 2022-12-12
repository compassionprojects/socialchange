Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :stories do
    collection do
      match 'search' => 'stories#search', via: [:get, :post], as: :search
    end
  end

  namespace :admin do
    resources :users
    resources :roles
    resources :permissions
    resources :stories

    root to: "users#index"
  end

  # Defines the root path route ("/")
  root "home#index"
end

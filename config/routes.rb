Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :stories do
    collection do
      match "search" => "stories#search", via: %i[get post], as: :search
    end
    resources :story_updates, as: :updates, shallow: true, shallow_prefix: "story"
  end

  namespace :admin do
    resources :users
    resources :roles
    resources :permissions
    resources :stories
    resources :story_updates

    root to: "users#index"
  end

  # Defines the root path route ("/")
  root "home#index"
end

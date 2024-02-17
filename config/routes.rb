Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions"}

  scope "(:lang)", lang: /#{I18n.available_locales.join("|")}/ do
    resources :stories do
      resources :contributions, only: %i[new create destroy]
      collection do
        match "search" => "stories#search", :via => %i[get post], :as => :search
        delete "remove_documents/:id" => "stories#remove_documents", :as => :remove_documents
      end
      resources :story_updates, as: :updates, shallow: true, shallow_prefix: "story"
      resources :discussions, shallow: true do
        resources :posts
      end
    end
    get "stories/:story_id/discussions/:id", to: "discussions#show", as: :story_discussion

    resources :preferences, only: %i[index update]
    resources :notifications, only: %i[index]
    root "home#index"
  end

  namespace :admin do
    resources :users
    resources :roles
    resources :permissions
    resources :stories
    resources :story_updates
    resources :discussions
    resources :posts
    resources :story_updates
    resources :categories do
      collection do
        post :update_tree
      end
    end

    root to: "users#enter"
  end
end

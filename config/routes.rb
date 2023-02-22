Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: "users/registrations" }

  scope "(:lang)", lang: /#{I18n.available_locales.join('|')}/ do
    resources :stories do
      collection do
        match "search" => "stories#search", via: %i[get post], as: :search
        match "remove_documents/:id" => "stories#remove_documents", via: [:delete], as: :remove_documents
      end
      resources :story_updates, as: :updates, shallow: true, shallow_prefix: "story"
      resources :discussions, shallow: true do
        resources :posts
      end
    end
    get 'stories/:story_id/discussions/:id', to: 'discussions#show', as: :story_discussion

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

    root to: "users#enter"
  end
end

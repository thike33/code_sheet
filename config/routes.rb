Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
    confirmations: "users/confirmations"
  }
  root "static_pages#top"
  resources :users, only: %i[show]
  resources :posts, only: %i[index new create show edit update destroy] do
    member do
      get 'user_index'
    end
    collection do
      get :bookmarks
    end

    resources :codes
    resources :likes, only: %i[create destroy], shallow: true
    get :likes, on: :collection
  end
  resources :bookmarks, only: %i[create destroy]
  get "privacy", to: "static_pages#privacy"
  get "terms_of_service", to: "static_pages#terms_of_service"
  get "contact", to: "static_pages#contact"

  get "up" => "rails/health#show", as: :rails_health_check
end

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

    resources :codes
  end

  get "up" => "rails/health#show", as: :rails_health_check
end

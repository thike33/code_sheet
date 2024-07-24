Rails.application.routes.draw do
  devise_for :users
  root "static_pages#top"
  resources :posts, only: %i[index new create show edit update]

  get "up" => "rails/health#show", as: :rails_health_check
end

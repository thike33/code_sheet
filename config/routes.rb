Rails.application.routes.draw do
  devise_for :users
  root "static_pages#top"
  resources :posts, only: %i[index]

  get "up" => "rails/health#show", as: :rails_health_check
end

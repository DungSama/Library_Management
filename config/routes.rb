Rails.application.routes.draw do
  devise_for :users
  resources :books do
    resources :reviews
    resources :borroweds
  end
  root'books#index'
  get 'search', to: "books#search"
  get 'display', to: "books#display"
end

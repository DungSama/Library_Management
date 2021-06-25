Rails.application.routes.draw do
  devise_for :users
  resources :books do
    resources :reviews
    resources :borroweds
  end
  root'books#index'
  get 'search', to: 'books#search'
  get 'display', to: 'books#display'
  get 'reading', to: 'books#reading'
  get 'paid', to: 'books#paid'
  get 'out_of_date', to: 'books#out_of_date'
 
end

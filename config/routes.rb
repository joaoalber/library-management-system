Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :books

  root to: "users#index"

  get 'search_book', to: 'books#search'
  post '/books/:id/borrow', to: 'books#borrow', as: 'borrow_book'
end

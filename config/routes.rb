Rails.application.routes.draw do
	get "toppages/index"
	get "home/about"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books, only: [:show, :index, :create, :edit, :update]
  delete 'books/:id' => 'books#destroy', as: 'destroy_book'
  resources :users, only: [:show, :index, :edit, :update]
  root "toppages#index"
end

Rails.application.routes.draw do
  get :search, controller: :main
  resources :movies
  resources :directors
  resources :posts
  #resources :categories
  resources :categories, constraints: { id: /.*/ }, path: '' do
    get :add, on: :member
    resources :posts
  end
  root to: 'categories#index'
end

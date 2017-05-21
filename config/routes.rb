Rails.application.routes.draw do
  resources :posts
  #resources :categories
  resources :categories, constraints: { id: /.*/ }, path: '' do
    get :add, on: :member
    resources :posts
  end
  root to: 'categories#index'
end

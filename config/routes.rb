Rails.application.routes.draw do
  get 'costs/new'
  get 'costs/edit'
  get 'costs/new'
  get 'costs/bank'
  get 'profiles/index'
  get 'profiles/new'
  get 'sessions/new'
  get 'users/new'
  get 'orders/buy'
  get 'orders/sell'
  get 'orders/buyer1'
  get 'orders/buyer2'
  get 'orders/seller1'
  get 'orders/seller2'
  get 'orders/finish'
  get 'products/home'
  get 'products/buy'
  get 'products/sell'
  get 'products/bid'
  get 'products/ask'
  
  post 'profiles/new', to: "profiles#create"
  patch 'profiles/new', to: "profiles#update"
  put 'profiles/new', to: "profiles#updade"
  
  post 'costs/new', to: "costs#create"
  patch 'costs/bank', to: "costs#update"
  put 'costs/bank', to: "costs#update"
  
  root 'products#home'
  
  resources :products
  resources :orders
  resources :profiles
  resources :costs
  
  resource :user, only: [:new, :create]
  get 'login', to: "sessions#new"
  post 'login', to: "sessions#create"
  delete 'logout', to: "sessions#destroy"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

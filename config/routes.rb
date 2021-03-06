Rails.application.routes.draw do
  get 'credits/new'
  get 'credits/show'
  get 'credit/new'
  get 'credit/show'
  get 'card/new'
  get 'card/show'
  get 'costs/new'
  get 'costs/edit'
  get 'costs/bank'
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

  post 'profiles/new', to: 'profiles#create'
  patch 'profiles/new', to: 'profiles#update'
  put 'profiles/new', to: 'profiles#updade'

  post 'costs/new', to: 'costs#create'
  patch 'costs/bank', to: 'costs#update'
  put 'costs/bank', to: 'costs#update'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :credits, only: [:new, :show] do
  collection do
    post 'show', to: 'credits#show'
    post 'pay', to: 'credits#pay'
    post 'delete', to: 'credits#delete'
  end
  end

  resources :orders#, :only => [:create, :show, :update]
  resources :profiles#, :only => [:create, :new, :show, :update]
  resources :costs#, :only => [:create, :show, :update]

  resource :user, only: %i[new create]

  root 'products#home'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

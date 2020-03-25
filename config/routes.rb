Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :posts
      resources :admin_users
      resources :members

      root to: "users#index"
    end

    authenticated do
      root :to => 'users#index'
      get 'static/homepage' => 'static#homepage'
    end
   
  get 'static/homepage' => 'static#homepage' 
  resources :posts
  resources :members
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users

  root to: 'static#homepage'


end

Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'pages#front'

  get '/home', to: 'videos#index'
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  get 'my_queue', to: 'queue_items#index'
  post 'update_queue', to: 'queue_items#update_queue'
  get 'people', to: 'relationships#index'
  get 'forgot_password', to: 'forgot_passwords#new'
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  get 'expired_token', to: 'pages#expired_token'
  get 'register/:token', to: 'users#new_with_invitation_token', as: 'register_with_token'

  resources :videos, only: [:show] do
    collection do
      post 'search', to: 'videos#search'
    end

    resources :reviews, only: [:create]
  end

  resources :genres, only: [:show]
  resources :users, only: [:create, :show]
  resources :sessions, only: [:create]
  resources :queue_items, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :forgot_passwords, only: [:create]
  resources :password_resets, only: [:show, :create]
  resources :invitations, only: [:new, :create]
end

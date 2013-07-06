Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'pages#front'

  get '/home', to: 'videos#index'
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'

  resources :videos, only: [:show] do
    collection do
      post 'search', to: 'videos#search'
    end
  end

  resources :genres, only: [:show]
  resources :users, only: [:create]

end

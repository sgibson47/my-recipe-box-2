Rails.application.routes.draw do
  root 'welcome#home'

  resources :users, only: [:new, :create, :show, :delete] do 
    resources :recipes, only: [:index]
    resources :makings, shallow: true
  end

  get '/signin', to: 'sessions#new'

  post '/signin', to: 'sessions#create'

  delete "/signout", to: "sessions#destroy"

  resources :ingredients

  resources :recipes

  get '/auth/facebook/callback' => 'sessions#create'
  get 'auth/failure', to: redirect('/signin')

  get '/makings' => 'makings#index'
end

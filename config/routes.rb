Rails.application.routes.draw do
  root 'welcome#home'

  resources :users, only: [:new, :create, :show, :delete]

  get '/signin', to: 'sessions#new'

  post '/signin', to: 'sessions#create'

  delete "/signout", to: "sessions#destroy"

  resources :ingredients
end

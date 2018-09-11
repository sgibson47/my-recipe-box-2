Rails.application.routes.draw do
  root 'welcome#home'

  resources :users, only: [:new, :create, :show]
end

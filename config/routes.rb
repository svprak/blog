Rails.application.routes.draw do
  root 'welcomes#index'
  resources :articles
  get 'signup', to: 'users#new'

  resources :users, except: [:new]
end

Rails.application.routes.draw do
  root 'welcomes#index'
  resources :articles

end

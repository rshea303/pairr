Rails.application.routes.draw do
  get '/auth/:provider/callback', to: "sessions#create"
  get '/dashboard', to: "static_pages#dashboard"
  root 'static_pages#home'

  resources :users
end

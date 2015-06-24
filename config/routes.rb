Rails.application.routes.draw do
  get '/auth/:provider/callback', to: "sessions#create"
  get '/dashboard', to: "static_pages#dashboard"
  get '/pairs', to: "static_pages#pairs"

  root 'static_pages#home'

  resources :users
end

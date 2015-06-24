Rails.application.routes.draw do
  get '/auth/:provider/callback', to: "sessions#create"
  delete '/logout', to: "sessoins#destroy"
  get '/dashboard', to: "static_pages#dashboard"
  get '/pairs', to: "static_pages#pairs"

  post '/rejects', to: "static_pages#rejects"
  post '/selections', to: "static_pages#selections"
  root 'static_pages#home'

  resources :users
end

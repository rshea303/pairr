Rails.application.routes.draw do
  get '/auth/:provider/callback', to: "sessions#create"
  root 'static_pages#home'
end

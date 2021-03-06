Rails.application.routes.draw do
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/signup' => "users#new"
  post '/users' => "users#create"
  
  get '/index' => "home#index"
  root "home#top"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

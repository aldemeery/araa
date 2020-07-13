Rails.application.routes.draw do
  root 'users#profile'
  
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :users, only: ['show', 'edit', 'update', 'destroy']
  post '/users/:id/follow', to: 'users#follow'
  post '/users/:id/unfollow', to: 'users#unfollow'
end

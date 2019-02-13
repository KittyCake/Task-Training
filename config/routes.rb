Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tasks#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :tasks, only: [ :new, :create, :edit, :update, :destroy ]

  resources :users, path: 'admin', except: [ :show ]
  get '/admin/:id', to: 'users#showtasks'

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
end

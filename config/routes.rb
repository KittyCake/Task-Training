Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tasks#index'
  resources :tasks, only: [ :index, :new, :create, :edit, :update, :destroy ]
end

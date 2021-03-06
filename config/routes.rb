Rails.application.routes.draw do
  resources :users, only: [:create, :new]
  resources :schedules, only: [:create, :new, :update, :index, :destroy]
  resources :make_plans, only: [:create]
  resources :today_missions, only: [:update]

  root 'schedules#show'
  get '/missions/:token/:user' => 'missions#index'
  get '/schedules/:token' => 'schedules#edit'
  get '/index' => 'users#index'
end

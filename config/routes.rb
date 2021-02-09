Rails.application.routes.draw do
  post '/callback' => 'linebot#callback'
  get '/liff' => 'linebot#liff'
  get '/dateme' => 'linebot#dateme'

  resources :schedules, only: [:create, :new, :update, :index]
  resources :make_plans, only: [:create]

  resources :users

  root 'schedules#show'
  get '/schedules/:token' => 'schedules#edit'
end

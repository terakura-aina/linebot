Rails.application.routes.draw do
  post '/callback' => 'linebot#callback'
  get '/liff' => 'linebot#liff'
  get '/dateme' => 'linebot#dateme'
  post 'make_plans' => 'make_plans#create'

  resources :schedules
  resources :users
end

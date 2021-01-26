Rails.application.routes.draw do
  post '/callback' => 'linebot#callback'
  get '/liff' => 'linebot#liff'
  get '/dateme' => 'linebot#dateme'

  resources :schedules
  resources :users
end

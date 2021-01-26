Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  post '/callback' => 'linebot#callback'
  get '/liff' => 'linebot#liff'
  get '/dateme' => 'linebot#dateme'

  resources :schedules
end

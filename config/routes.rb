Rails.application.routes.draw do
  post '/callback' => 'linebot#callback'
  get '/liff' => 'linebot#liff'
  get '/dateme' => 'linebot#dateme'

  resources :schedules do
    resources :make_plans, only: [:create]
  end
  resources :users
end

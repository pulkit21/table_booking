Rails.application.routes.draw do
  # devise_for :users
  use_doorkeeper


  resources :restaurants

  get '/bookings' => "booking#index"
  post '/booking' => "booking#create"
  get '/booking' => "booking#show"
  put '/booking' => "booking#update"
  delete '/booking' => "booking#destroy"
  devise_for :users, controllers: { sessions: "sessions" }
end

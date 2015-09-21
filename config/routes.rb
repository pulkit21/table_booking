Rails.application.routes.draw do
  devise_for :users

  use_doorkeeper do
    controllers :applications => 'oauth/applications'
  end


  scope '/api' do
    resources :restaurants
    resources :applications, except: [:new, :edit]
    get '/bookings' => "booking#index"
    post '/booking' => "booking#create"
    get '/booking' => "booking#show"
    put '/booking' => "booking#update"
    delete '/booking' => "booking#destroy"
    devise_scope :user do
      post '/users/sign_in' => "sessions#create"
      delete '/users/sign_out' => "sessions#destroy"
      post '/users' => "registrations#create"
      put '/users' => "registrations#update"
      post '/users/password' => "passwords#create"
      put '/users/password' => "passwords#update"
    end
  end
end

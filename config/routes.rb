Rails.application.routes.draw do
  root 'searches#search'
  get '/auth', to: 'sessions#create'
  get '/search', to: 'searches#search'
  post '/search', to: 'searches#foursquare'
  get '/friends', to: 'searches#friends'
end

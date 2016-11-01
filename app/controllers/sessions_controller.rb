class SessionsController < ApplicationController
  # whenever users do not have an access token stored in their session,
  # they will be redirected to the Foursquare authorization URL
  skip_before_action :authenticate_user, only: :create

  # Make sure to skip the authenticate_user before_action when you're creating a session,
  # otherwise you'll end up in an infinite loop of trying to figure out who the user is,
  # which is a very existential bug
  def create
    resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
      req.params['client_id'] = ENV['FOURSQUARE_CLIENT_ID']
      req.params['client_secret'] = ENV['FOURSQUARE_SECRET']
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = params[:code]
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end

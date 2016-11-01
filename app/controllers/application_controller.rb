class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

  private

  # redirect the user to https://foursquare.com/oauth2/authenticate if the user is not already logged in
  def authenticate_user
    client_id = ENV['FOURSQUARE_CLIENT_ID']
    redirect_uri = CGI.escape("http://localhost:3000/auth")
    foursquare_url = "https://foursquare.com/oauth2/authenticate?client_id=#{client_id}&response_type=code&redirect_uri=#{redirect_uri}"
    redirect_to foursquare_url unless logged_in?
  end

  # figure out if a user has already authenticated to Foursquare in this session
  def logged_in?
    !!session[:token]
  end
end

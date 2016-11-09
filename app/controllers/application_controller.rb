class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

private

  def authenticate_user
    client_id = ENV['FOURSQUARE_CLIENT_ID']
    redirect_uri = CGI.escape("http://localhost:3000/auth")
    foursquare_url = "https://foursquare.com/oauth2/authenticate?client_id=#{client_id}&response_type=code&redirect_uri=#{redirect_uri}"
    redirect_to foursquare_url unless logged_in?
  end

  #this private method we have our client id. he have our redirect path a d we have a vr qual to the foursquare website
  #that take in the client id , and also provides the redirect url. if the user is logged in we do not ask for the code. the token is already saved in the
  #session controller. if the user is logged in the oauth page redirects to the /auth page because its the default callback url.













  private


  def logged_in?           #this method checks if the user has a access token stored in their session.
    !!session[:token]
  end







end

class SearchesController < ApplicationController
  def search


  end

  #upon success of Oauth we are sent to the search action to the render the search page



  def friends
  resp = Faraday.get("https://api.foursquare.com/v2/users/self/friends") do |req|
    req.params['oauth_token'] = session[:token]
    # don't forget that pesky v param for versioning
    req.params['v'] = '20160201'
    end
    @friends = JSON.parse(resp.body)["response"]["friends"]["items"]
  end


  #if we want to render friends of a person in the search friends view we use faraday again to fetch the api response
  #we pass the params oauth token equal to the session token which we store in the session and upon success we parse the Json and grab all the
  #friends in an array to render it in the erb page. Also the oauth token is used to authenticate a user.





  def foursquare

    client_id = ENV['FOURSQUARE_CLIENT_ID']
    client_secret = ENV['FOURSQUARE_SECRET']

    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body = JSON.parse(@resp.body)

    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    render 'search'

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
      render 'search'
  end
end



#post search leads to the foursquare method which first sets vaariables to the client id and secret.
#we then use faraday to fetch information for us. from the api. we send a ge trequest to the earch api with params on the key client_id equal
#to our client id, secret......everything. we then parse the string into a JSON object by passing the response body to the class JSON the method parse and the argument @resp.body

#then we use the faraday success method to chekc if the response was a sucess and if it was we grab the value from the json formate body.
#if not we set a variable errors to grab the error message in meta and display it. We render search again.

#we  can set a timer to see how long the response takes to load we can use the rescue faraday timeout::error module to create an weeor message and render search with the message.

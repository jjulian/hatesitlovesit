class UsersController < ApplicationController
  CONSUMER_KEY = 'nBW6AZvfl0eo6MZArFkqA'
  CONSUMER_SECRET = 'n0d4KapOmK9no3ZhGbnZlbobRzwLoahyzPXFDoHGW44'

  def sign_in
    request_token = User.twitter_oauth.get_request_token(:oauth_callback => sign_in_callback_url) 
    session[:twitter_oauth_request_token] = request_token.token
    session[:twitter_oauth_request_secret] = request_token.secret
    redirect_to request_token.authorize_url
  end
  
  def sign_in_callback
    if params[:denied]
      redirect_to root_url
    elsif params[:oauth_verifier]
      access_token = OAuth::RequestToken.new(
        User.twitter_oauth, 
        session.delete(:twitter_oauth_request_token), 
        session.delete(:twitter_oauth_request_secret)
      ).get_access_token(:oauth_verifier => params[:oauth_verifier])

      user = User.find_by_twitter_oauth_token(access_token.token)
      if user
        session[:user_id] = user.id
        user.update_twitter_profile
      else
        user = User.new(:twitter_oauth_token => access_token.token, :twitter_oauth_secret => access_token.secret)
        if user.save
          session[:user_id] = user.id
        else
          flash[:error] = user.errors.full_messages.join('<br/>')
        end
      end
      redirect_to root_url
    end
  end
  
  def sign_out
    session[:user_id] = nil
    redirect_to root_url
  end

end

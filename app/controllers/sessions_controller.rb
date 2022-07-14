class SessionsController < ApplicationController
  def new
    resp = TwitterOauth.initialize(ENV['ST_TWITTER_KEY'], ENV['ST_TWITTER_SECRET'])
    render :json => resp.to_json
  end

  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = user.id

    redirect_to new_user_tweet_path(user)
  end

  def destroy
    session[:user_id] = nil

    redirect_to root_path
  end
end

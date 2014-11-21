class TweetsController < ApplicationController
  def index
    @user = current_user
    @tweets = @user.tweets
  end

  def new
    @user = current_user
  end

  def search
    # Important: portfolio dependency
    @results = Tweet.tweets_by_user(params[:handle])
    render :json => @results.to_json
  end

  def search_topic
    handle  = params[:handle]
    keyword = params[:keyword]
    results = Tweet.tweets_by_topic(handle, keyword)
    render json: results.to_json
  end

  def search_hashtag
    results = Tweet.tweets_by_hashtag(params[:hashtag])
    render json: results.to_json
  end

  def find
    @user = current_user
    if params[:handle]
      @results = Tweet.tweets_by_user(params[:handle])
    elsif params[:keywords]
      @results = Tweet.tweets_by_keywords(params[:keywords])
    else
      @results = Tweet.tweets_by_hashtag(params[:hashtag])
    end

    render json: @results.to_json
  end

  def create
    user = current_user
    tweet = Tweet.create({handle: params[:handle], content: params[:content], link: params[:link]})
    if tweet.save
      user.tweets.push(tweet)
    else
      tweet = Tweet.find_by(link: params[:link])
      user.tweets.push(tweet)
    end
    redirect_to user_tweets_path(user)
  end

  def show
  end

  def destroy
    user  = User.find(params[:user_id])
    tweet = Tweet.find(params[:id])
    user.tweets.delete(tweet)
    redirect_to user_tweets_path(user)
  end
end

class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
    respond_to do |format|
      format.json { render :json => @tweets.to_json }
      format.html
    end
  end

  def new
    @user = current_user
    # Search form
  end

  def search
    # Important: portfolio dependency
    @results = Tweet.tweets_by_user(params[:handle])
    render :json => @results.to_json
  end

  def find
    @user = current_user
    if params[:handle]
      @results = Tweet.tweets_by_user(params[:handle])
    else
      @results = Tweet.tweets_by_keywords(params[:keywords])
    end
  end

  def create
    @tweet = Tweet.create({handle: params[:handle], content: params[:content], url: params[:url]})
    redirect_to tweet_path(@tweet)
  end

  def show
  end

  def destroy
    @tweet = Tweet.delete(params[:id])
    redirect_to tweets_path
  end
end

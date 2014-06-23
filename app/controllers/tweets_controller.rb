class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
    respond_to do |format|
      format.json { render :json => @tweets.to_json }
      format.html
    end
  end

  def new
  end

  def search
    @results = Tweet.get_tweets(params[:handle])
  end  

  def create
    @tweet = Tweet.create({handle: params[:handle], content: params[:content], url: params[:url]})
    redirect_to tweet_path(@tweet)
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def destroy
    @tweet = Tweet.delete(params[:id])
    redirect_to tweets_path
  end
end
class TweetsController < ApplicationController
  def new
  end

  def search
    term = params[:term]
    if params[:type] == 'username'
      @results = TweetSearch.username(term)
    else
      @results = TweetSearch.keywords(term)
    end

    render :json => @results.to_json
  end
end

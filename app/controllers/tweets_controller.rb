class TweetsController < ApplicationController
  def new
  end

  def search
    term = params[:term]
    count = params[:count]

    if params[:type] == 'username'
      @results = TweetSearch.username(term, count)
    else
      @results = TweetSearch.keywords(term, count)
    end

    render :json => @results.to_json
  end
end

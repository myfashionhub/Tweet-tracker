class Tweet < ActiveRecord::Base
  has_and_belongs_to_many :users

  def self.tweets_by_user(username)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['ST_TWITTER_KEY']
      config.consumer_secret     = ENV['ST_TWITTER_SECRET']
    end

    tweet_array = client.user_timeline(username, {count: 5})
    results = tweet_array.map do |tweet|
      if tweet.urls[0] != nil
        url = tweet.urls[0].expanded_url.to_s
      else
        url = nil
      end
      {handle: username,
       content: tweet.text,
       link: 'https://twitter.com'+tweet.url.path,
       url: url}
    end
    return results
  end

  def self.tweets_by_keywords(keywords)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['ST_TWITTER_KEY']
      config.consumer_secret     = ENV['ST_TWITTER_SECRET']
    end

    tweet_array = client.search(keywords).attrs[:statuses]
    results = tweet_array.map do |tweet|
      {handle: tweet[:user][:screen_name],
       content: tweet[:text]
      }
    end
    return results
  end
end



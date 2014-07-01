class Tweet < ActiveRecord::Base

  def self.get_tweets(username)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['ST_TWITTER_KEY']
      config.consumer_secret     = ENV['ST_TWITTER_SECRET']
    end

    tweet_array = client.user_timeline(username, {count: 3})
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

end



module TweetSearch
  def self.username(username)
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

  def self.keywords(keywords)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['ST_TWITTER_KEY']
      config.consumer_secret     = ENV['ST_TWITTER_SECRET']
    end

    tweet_array = client.search(keywords, lang: 'en').attrs[:statuses]
    results = tweet_array.map do |tweet|
      {handle: tweet[:user][:screen_name],
       content: tweet[:text],
       link: tweet[:id]
      }
    end
    return results
  end

  def self.hashtag(hashtag)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['ST_TWITTER_KEY']
      config.consumer_secret     = ENV['ST_TWITTER_SECRET']
    end

    tweet_array = client.search("#{hashtag} -rt", lang: 'en').attrs[:statuses]
    results = tweet_array.map do |tweet|
      {handle: tweet[:user][:screen_name],
       content: tweet[:text],
       link: tweet[:id]
      }
    end
    return results
    binding.pry
  end

  def get_following(username)
    following = client.friends(username)
    following.first.screen_name
    following.to_a[index].screen_name
  end

end



#Twitter::Tweet
#tweet.media
#tweet.id
#tweet.user_mentions[index].screen_name
#tweet.hashtags[index].text
#link: tweet.urls[index].expanded_url.to_str


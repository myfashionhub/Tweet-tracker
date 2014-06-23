module TweetFetch
  def self.get_tweets(username)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "P69nzcI8IPsCaBy43EzLft5Hq"
      config.consumer_secret     = "f21dxHv11ByIyctkrtBsVVUMIcuh2hJwbgzv2VeedbkeZnEGdE"
      config.access_token        = "240042413-nefpXjpUKgdjWtIPbgjaWQRIn3umAz7opll2nbZR"
      config.access_token_secret = "HS3Xh4vEVSLAWStLZonDBsAjFoRp6USyTMEt0e6RezPqj"   
    end  

    tweet_array = client.user_timeline(username)
    results = tweet_array.map do |tweet|
      if tweet.urls[0] != nil
        {handle: username,
         content: tweet.text, 
         url: tweet.urls[0].expanded_url.to_s}
      else 
        {handle: username,
         content: tweet.text}
      end  
    end
    return results
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

end

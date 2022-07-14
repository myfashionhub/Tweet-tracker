require 'json'
require 'net/http'
require 'uri'

module TweetSearch
  NUM_RESULTS = 5

  def self.token
    @token ||= begin
      uri = URI('https://api.twitter.com/oauth2/token')
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(uri.path.concat('?grant_type=client_credentials'))
      request.basic_auth(ENV['ST_TWITTER_KEY'], ENV['ST_TWITTER_SECRET'])

      resp = https.request(request)
      JSON.parse(resp.body)['access_token']
    end
  end

  def self.client
    @client ||= Twitter::REST::Client.new do |config|
      # config.consumer_key = ENV['ST_TWITTER_KEY']
      # config.consumer_secret = ENV['ST_TWITTER_SECRET']
      config.bearer_token = self.token
    end
  end

  def self.username(username, num_results=NUM_RESULTS)
    uri = URI('https://api.twitter.com/1.1/statuses/user_timeline.json')
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(uri.path.concat("?screen_name=#{username}&count=#{num_results}"))
    request['Authorization'] = "Bearer #{self.token}"
    request['Accept'] = 'application/json'
    request['ContentType'] = 'application/json'

    resp = https.request(request)
    tweet_array = JSON.parse(resp.body)

    tweet_array.map do |tweet|
      {
        handle: username,
        content: tweet['text'],
        link: "https://twitter.com/#{username}/status/#{tweet['id']}",
      }
    end
  end

  def self.keywords(keywords)
    tweet_array = self.client.search(keywords, lang: 'en').attrs[:statuses]
    tweet_array.map do |tweet|
      {
        handle: tweet[:user][:screen_name],
        content: tweet[:text],
        link: tweet[:id],
      }
    end
  end

  def self.hashtag(hashtag)
    tweet_array = self.client.search("#{hashtag} -rt", lang: 'en').attrs[:statuses]
    tweet_array.map do |tweet|
      {
        handle: tweet[:user][:screen_name],
        content: tweet[:text],
        link: tweet[:id],
      }
    end
  end

  def self.topic(handle, keyword, num_results=NUM_RESULTS)
    self.client
      .search("#{keyword} from:#{handle}", result_type: 'popular')
      .take(num_results)
      .collect { |tweet| "@#{tweet.user.screen_name}: #{tweet.text}" }
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

=begin


=end


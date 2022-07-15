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

  def self.search_twitter_api(url, term, query_string)
    uri = URI(url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(uri.path.concat(query_string))
    request['Authorization'] = "Bearer #{self.token}"
    request['Accept'] = 'application/json'
    request['ContentType'] = 'application/json'

    resp = https.request(request)
    JSON.parse(resp.body)
  end

  def self.username(username, num_results=NUM_RESULTS)
    results = self.search_twitter_api(
      'https://api.twitter.com/1.1/statuses/user_timeline.json',
      username,
      "?screen_name=#{username}&count=#{num_results}"
    )

    results.map { |tweet| self.build_tweet_result(username, tweet) }
  end

  def self.keywords(keyword, num_results=NUM_RESULTS)
    url = 'https://api.twitter.com/1.1/search/tweets.json'
    query_string = "?q=#{keyword}&lang=en&count=#{num_results}"
    result = self.search_twitter_api(url, keyword, query_string)

    result['statuses'].map { |tweet| self.build_tweet_result(tweet['user']['screen_name'], tweet) }
  end

  def self.topic(handle, keyword, num_results=NUM_RESULTS)
    self.client
      .search("#{keyword} from:#{handle}", result_type: 'popular')
      .take(num_results)
      .collect { |tweet| "@#{tweet.user.screen_name}: #{tweet.text}" }
  end

  def self.build_tweet_result(username, tweet)
    {
      handle: username,
      content: tweet['text'],
      link: "https://twitter.com/#{username}/status/#{tweet['id']}",
      related_urls: tweet['entities']['urls'],
    }
  end

end

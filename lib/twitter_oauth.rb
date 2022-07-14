require 'base64'
require 'cgi'
require 'hmac-sha1'
require 'net/http'
require 'securerandom'
require 'uri'

module TwitterOauth
  def self.initialize(twitter_key, twitter_secret)
    oauth_url = 'https://api.twitter.com/oauth/request_token'
    uri = URI(oauth_url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(uri.path.concat('?oauth_callback=http%3A%2F%2Flocalhost%3A3000%2Fauth%2Ftwitter%2Fcallback'))
    nonce = "15557068dc55edea6daff1d2126db28c7668c593c4" # SecureRandom.hex(21)
    timestamp = 1657824148 # Time.now.to_i

    signature = "POST&#{CGI.escape(oauth_url)}&" +
      CGI.escape(
        "oauth_callback=http%3A%2F%2Flocalhost%3A3000%2Fauth%2Ftwitter%2Fcallback&" +
        "oauth_consumer_key=#{twitter_key}&" +
        "nonce=#{nonce}&" +
        "oauth_signature_method=HMAC-SHA1&" +
        "oauth_timestamp=#{timestamp}&" +
        "oauth_version=1.0"
      )
    signing_key = "#{CGI.escape(twitter_secret)}&"
    puts "signature #{signature}"
    hmac = HMAC::SHA1.new(signing_key)
    hmac.update(signature)
    puts "base64 #{CGI.escape(Base64.encode64(hmac.digest))}"

    request['Authorization'] = "OAuth " +
      "oauth_consumer_key='#{twitter_key}', " +
      "oauth_nonce='#{nonce}', " +
      "oauth_signature_method='HMAC-SHA1', " +
      "oauth_signature='#{CGI.escape(Base64.encode64(hmac.digest))}', " +
      "oauth_timestamp='#{timestamp}', " +
      "oauth_version='1.0'"
    puts request.path
    puts request.to_json

    https.request(request)
  end
end

# POST&https%3A%2F%2Fapi.twitter.com%2Foauth%2Frequest_token&oauth_consumer_key%3DGa21vfH224Cc6b9nDXnWD7iO1%26nonce%3D61e8e80ac336ade51ed58588c46de4da1534152fd0%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1657823868%26oauth_version%3D1.0

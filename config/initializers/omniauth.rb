Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['ST_TWITTER_KEY'], ENV['ST_TWITTER_SECRET']
end

  require "#{Rails.root}/lib/tweet_module.rb"

class Tweet < ActiveRecord::Base
  has_and_belongs_to_many :users

  def self.tweets_by_user(username)
    TweetSearch.username(username)
  end

  def self.tweets_by_keywords(keywords)
    TweetSearch.keywords(keywords)
  end
end



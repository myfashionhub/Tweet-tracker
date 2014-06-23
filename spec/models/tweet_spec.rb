require 'spec_helper'

describe Tweet do

  before :each do
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "P69nzcI8IPsCaBy43EzLft5Hq"
      config.consumer_secret     = "f21dxHv11ByIyctkrtBsVVUMIcuh2hJwbgzv2VeedbkeZnEGdE"
    end
  end
      
  describe '#get_tweets' do 
    it 'should return an array of tweets' do
      actual = Tweet.get_tweets('ploxiln').size
      expected = 20
      expect(actual).to eq(expected)
    end

    it 'get tweet strings that are 140 characters or fewer' do
      actual = Tweet.get_tweets('ploxiln')[0][:content].length
      actual.should be <= 140
    end
  end

end

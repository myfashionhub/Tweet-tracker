class User < ActiveRecord::Base
  def self.from_omniauth(data)
    @user = User.find_by(handle: data.info.nickname) || create_with_omniauth(data)
  end

  def self.create_with_omniauth(data)
    @user = User.create({
      handle: data.info.nickname,
      twitter_token: data.extra.access_token.params[:oauth_token],
      twitter_token_secret: data.extra.access_token.params[:oauth_token_secret]
      })
  end
end

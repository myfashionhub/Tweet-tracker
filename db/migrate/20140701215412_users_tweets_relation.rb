class UsersTweetsRelation < ActiveRecord::Migration
  def change
    create_table :users_tweets, id: false do |t|
      t.belongs_to :user
      t.belongs_to :tweet
    end
  end
end

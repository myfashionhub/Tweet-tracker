class UsersTweetsRelation < ActiveRecord::Migration
  def change
    create_table :tweets_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :tweet
    end
  end
end

class UsersTweetsRelation < ActiveRecord::Migration[7.0]
  def change
    create_table :tweets_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :tweet
    end
  end
end

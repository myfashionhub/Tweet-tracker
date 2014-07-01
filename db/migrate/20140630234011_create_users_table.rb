class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :handle
      t.string :twitter_token
      t.string :twitter_token_secret
      t.timestamps
    end
  end
end

class CreateUsersTable < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :handle
      t.string :twitter_token
      t.string :twitter_token_secret
      t.string :image
      t.timestamps
    end
  end
end

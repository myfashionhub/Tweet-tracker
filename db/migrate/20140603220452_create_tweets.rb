class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :url
      t.string :handle
      t.string :content
      t.string :link
      t.timestamps
    end
  end
end

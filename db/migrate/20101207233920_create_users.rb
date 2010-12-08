class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :twitter_oauth_token
      t.string :twitter_oauth_secret
      t.text :twitter_profile
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

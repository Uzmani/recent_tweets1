class TwitterUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|
      # t.has_many :tweets
      t.string :username
    end
  end
end

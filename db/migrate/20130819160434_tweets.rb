class Tweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :twitter_user
      t.string :text
      # t.integer :twitter_user_user_id

      t.timestamps
    end  
  end
end

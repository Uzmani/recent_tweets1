class TwitterUser < ActiveRecord::Base
  has_many :tweets
  validates_uniqueness_of :username

  def fetch_tweets!
   puts "FETCHING TWEETS"
   if self.tweets.any?
      self.tweets.each do |tweet|
        tweet.destroy
      end  
    end

    username = self.username
    
    tweets = Twitter.client.user_timeline(username)
    puts "REPOPULATING DB"
    tweets.each do |tweet|
      Tweet.create(twitter_user_id: self.id, text: tweet.text)
    end   
  end

  def tweets_stale?
    last_fetch_time = self.tweets.last.created_at


    time_difference = (Time.now - last_fetch_time) / 60
    time_difference > 15
  
  end

  def tweets_stale_fancier?
    #Grab time of user's most recent tweet
    most_recent_tweet_time = Twitter.client.user_timeline(self.username).first.attrs[:created_at].to_datetime

    #If that time is more recent than the last created_at, then fetch tweets. 
    # p most_recent_tweet_time
    p self.tweets 
    most_recent_tweet_time > self.tweets.last.created_at
  end

end

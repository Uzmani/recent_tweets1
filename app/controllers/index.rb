get '/' do
  erb :index
end

get '/username' do   

  @username = params[:username]

  TwitterUser.create(username: params[:username])

  @user = TwitterUser.find_by_username(params[:username])
  
  @user.fetch_tweets! if @user.tweets.empty? || @user.tweets_stale_fancier?
  @tweets = @user.tweets.limit(10)
  erb :username
end

post '/' do 

  # Twitter.update("I'm tweeting this using my Ruby App!")
  Twitter.client.update(params[:tweet_text])
  @tweet= params[:tweet_text]
  # "i am the new tweet: " + params[:tweet_text]
   # erb :index
   erb :_tweet_list, :layout => false
   # return params[:tweet_text]
end


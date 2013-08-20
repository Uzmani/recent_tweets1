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

post '/tweet' do
  input = params[:new_tweet]
  Twitter.client.update(input)
  erb :tweet
end

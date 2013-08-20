get '/' do
  # @name = Twitter.client.user.name
  # @info = Twitter.client.user.description
  @user_since = Twitter.client.user.created_at
  @profile_image_url = Twitter.client.user.profile_image_url_https
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
  input = params[:new_tweet]
  Twitter.client.update(input)
  erb :index
end

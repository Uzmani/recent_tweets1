# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'
require 'twitter'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'
# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# client = Twitter.configure do |config|
#   config.consumer_key = 'nKlzlQoG8ppADM9rRiP8Q'
#   config.consumer_secret = 'IReGX1g5QxyMAH4nTXqqVNejsXFS3J8Em7XaoaY'
#   config.oauth_token = '23558477-EC6GYMo4zbl8vK9pb8BqEV3Lad05RtXnefxsU9dA'
#   config.oauth_token_secret = 'mP2lFSy4ZFKz2inG3m7PocIqWvRsaK5AT9zhmsQtII'
# end


require APP_ROOT.join('config', 'database')
# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }
env_config = YAML.load_file(APP_ROOT.join('config', 'keys.yaml'))

# env_config.each do |key, value|
#   ENV[key] = value
# end

client = Twitter.configure do |config|
  config.consumer_key = env_config['YOUR_APP_CONSUMER_KEY']
  config.consumer_secret = env_config['YOUR_APP_CONSUMER_SECRET']
  config.oauth_token = env_config['ACCESS_TOKEN']
  config.oauth_token_secret = env_config['ACCESS_TOKEN_SECRET']
end




# Set up the database and models
# require APP_ROOT.join('config', 'database')


# https://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=twitterapi&count=2
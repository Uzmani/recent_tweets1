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

require APP_ROOT.join('config', 'database')
# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }
env_config = YAML.load_file(APP_ROOT.join('config', 'keys.yaml'))

client = Twitter.configure do |config|
  config.consumer_key = ENV['YOUR_APP_CONSUMER_KEY']
  config.consumer_secret = ENV['TWITTER_SECRET']
  config.oauth_token = ENV['ACCESS_TOKEN']
  config.oauth_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

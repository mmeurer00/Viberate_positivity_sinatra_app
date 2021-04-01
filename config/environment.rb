ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
require 'uri'
require 'net/http'
require 'openssl'
require 'rack-flash'

Bundler.require(:default, ENV['SINATRA_ENV'])
require 'dotenv/load'
require 'time_ago_in_words'
ActiveRecord::Base.establish_connection(ENV['SINATRA_ENV'].to_sym)


require_all 'app'


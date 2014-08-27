#
# Agora
# A public community calendar aggregator JSON API
# v0.0.1

require 'sinatra/base'
require 'sinatra/config_file'
require 'json'
require 'dotenv'
Dotenv.load

require_relative 'models'

class Agora < Sinatra::Application
  register Sinatra::ConfigFile

  config_file("config.yml")
  # Set up DB
  # DataMapper.setup(:default, "#{ENV['DB_ADAPTER']}://#{ENV['DB_HOSTNAME']}/#{ENV['DB_NAME']}")
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/agora.db")


  Models::Event.auto_upgrade!

  DataMapper.finalize

  require_relative 'routes'

end

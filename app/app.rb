#
# Agora
# A public community calendar aggregator JSON API
# v0.0.1

require "sinatra/base"
require "sinatra/config_file"
require "json"
require "dotenv"
Dotenv.load

require "./app/models"

class Agora < Sinatra::Application

  # Set up DB
  DataMapper.setup(:default, ENV["DATABASE_URL"] || "#{ENV["DB_ADAPTER"]}://#{ENV["DB_HOSTNAME"]}/#{ENV["DB_NAME"]}")

  Event.auto_upgrade!
  Source.auto_upgrade!

  DataMapper.finalize

  require "./app/routes"

end

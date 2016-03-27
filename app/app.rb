#
# Agora
# A public community calendar aggregator JSON API
# v0.0.1

require "sinatra/base"
require "sinatra/config_file"
require "json"
require "better_errors"

require "./app/models"


class Agora < Sinatra::Application
  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = __dir__
  end


  # Set up DB
  DataMapper.setup(:default, ENV["DATABASE_URL"] || "postgres://localhost/agora")

  Event.auto_upgrade!
  Source.auto_upgrade!

  DataMapper.finalize

  require "./app/routes"

end

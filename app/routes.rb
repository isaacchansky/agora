require 'slim'
require 'data_mapper'
require 'dm-sqlite-adapter'

class Agora < Sinatra::Application

  # Documentation lives at here
  get '/' do
    slim :docs
  end

  # EVENTS
  get '/events' do
    halt 200, Models::Event.all.to_json
  end
  post '/events' do
    event = Models::Event.create(JSON.parse(request.body.read))
    halt 201, event.to_json
  end

  # 404
  not_found do
    content_type :json
    halt 404, { error: 'URL is not found' }.to_json
  end

end

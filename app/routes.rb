require 'slim'
require 'data_mapper'
require './app/view_helpers'

class Agora < Sinatra::Application

  # Documentation lives at here
  get '/' do
    slim :docs
  end

  # Demo for... demo purposes
  get '/demo' do
    @events = Event.all
    slim :demo
  end

  # 404
  not_found do
    content_type :json
    halt 404, { error: 'URL is not found' }.to_json
  end

  ####################
  # EVENTS
  ####################
  get '/events' do
    content_type :json
    halt 200, Event.all.to_json
  end


  get '/events/:id' do
    content_type :json
    event = Event.get(params[:id])
    if event
      halt 200, event.to_json
    else
      halt 404, { :message => "Event not found" }.to_json
    end
  end


  ####################
  # Source
  ####################
  get '/sources' do
    content_type :json
    halt 200, Source.all.to_json
  end

  post '/sources' do
    content_type :json
    source = Source.new(JSON.parse(request.body.read))
    begin
      source.save
      halt 201, source.to_json
    rescue DataMapper::SaveFailureError => e
      errors = e.resource.errors.full_messages
      halt 400, { :errors => errors }.to_json
    end
  end

  get '/sources/:id' do
    content_type :json
    source = Source.get(params[:id])
    if source
      halt 200, source.to_json
    else
      halt 404, { :message => "Source not found" }.to_json
    end
  end

  put '/sources/:id' do
    content_type :json
    source = Source.get(params[:id])
    if source == nil
      halt 404, { :message => "Source not found" }.to_json
    end

    begin
      source.update(JSON.parse(request.body.read))
      halt 200, source.to_json
    rescue DataMapper::SaveFailureError => e
      errors = e.resource.errors.full_messages
      halt 400, { :errors => errors }.to_json
    end
  end

  delete '/sources/:id' do
    content_type :json
    source = Source.get(params[:id])
    if source == nil
      halt 404, { :message => "Source not found" }.to_json
    end

    begin
      source.destroy
      halt 204, {}.to_json
    rescue DataMapper::SaveFailureError => e
      errors = e.resource.errors.full_messages
      halt 400, { :errors => errors }.to_json
    end
  end

end

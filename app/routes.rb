require "sinatra/namespace"
require "data_mapper"
require "./app/view_helpers"
require "slim"

class Agora < Sinatra::Application

  ############################################################
  # SETUP
  ############################################################

  before "/api/*" do
    content_type 'application/json'
  end

  ############################################################
  # DOCS & STUFF
  ############################################################

  get "/" do
    slim :docs
  end

  # Demo for... demo purposes
  get "/demo" do
    @events = Event.all
    slim :demo
  end

  # 404
  not_found do
    content_type 'application/json'
    halt 404, { error: "URL is not found" }.to_json
  end



  ############################################################
  # API V-1.0
  ############################################################
  namespace "/api/v1" do


    ##########################################################
    # E V E N T S
    ##########################################################

    get "/events" do
      # TODO: add some sort of pagination.
      halt 200, Event.all.to_json

    end


    get "/events/:id" do

      event = Event.get(params[:id])
      if event
        halt 200, event.to_json
      else
        halt 404, { message: "Event not found" }.to_json
      end

    end

    # Events search

    get "/search" do

      # search for terms in description and title
      search_results = Event.ft_search(params[:q], [:description, :title])

      halt 200, search_results.to_json

    end



    ##########################################################
    # S O U R C E S
    ##########################################################

    get "/sources" do

      halt 200, Source.all.to_json

    end


    post "/sources" do

      source = Source.new(JSON.parse(request.body.read))
      begin
        source.save
        halt 201, source.to_json
      rescue DataMapper::SaveFailureError => e
        errors = e.resource.errors.full_messages
        halt 400, { errors: errors }.to_json
      end

    end


    get "/sources/:id" do

      source = Source.get(params[:id])
      if source
        halt 200, source.to_json
      else
        halt 404, { message: "Source not found" }.to_json
      end

    end


    put "/sources/:id" do

      source = Source.get(params[:id])
      if source == nil
        halt 404, { message: "Source not found" }.to_json
      end

      begin
        source.update( JSON.parse(request.body.read) )
        halt 200, source.to_json
      rescue DataMapper::SaveFailureError => e
        errors = e.resource.errors.full_messages
        halt 400, { errors: errors }.to_json
      end

    end


    delete "/sources/:id" do

      source = Source.get(params[:id])
      if source == nil
        halt 404, { message: "Source not found" }.to_json
      end

      begin
        source.destroy
        halt 204, {}.to_json
      rescue DataMapper::SaveFailureError => e
        errors = e.resource.errors.full_messages
        halt 400, { errors: errors }.to_json
      end

    end


  end
end

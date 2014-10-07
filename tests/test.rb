ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require 'json'
require_relative '../app/app'

include Rack::Test::Methods

def app
  Agora
end


describe "API::EVENT" do
  describe "get /events" do
    before do
      get "/events"
    end

    it "should return a 200 always" do
      last_response.status.must_equal 200
    end

  end

end


describe "API::SOURCE" do

  describe "get /sources" do
    before do
      get "/sources"
    end

    it "should return a 200 always" do
      last_response.status.must_equal 200
    end
  end


  describe "post /sources" do
    before do
      Source.all.destroy
      new_source_json = {:name  => "test source",:type => "ical",:url => "http://localhost:9393/public/test-data.ics"}.to_json
      post "/sources", new_source_json
    end

    it "should be able to create a source" do
      last_response.status.must_equal 201
      JSON.parse(last_response.body)["id"].wont_be_nil
    end

    it "should not allow duplicate URLs" do
      post "/sources", {:name  => "test source",:type => "ical",:url => "http://localhost:9393/public/test-data.ics"}.to_json

      last_response.status.must_equal 400
      JSON.parse(last_response.body)["errors"].must_include "Url is already taken"
    end

  end


  describe "get /events" do
    before do
      get "/events"
    end

    it "should return a 200, always" do
      last_response.status.must_equal 200
    end

  end

end

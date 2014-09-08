ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require_relative '../app/app'

include Rack::Test::Methods

def app
  Agora.new
end

describe "basic routes" do
  it "should return a status 404 if incorrect url" do
    get "/bogus-route"
    last_response.status.must_equal 404
  end

  it "should return a json message if incorrect url" do
    get "/bogus-route"
    assert last_response.body.include? "not found"
  end
end


describe "Events" do

  it "should return a 200" do
    get "/events"
    last_response.status.must_equal 200
  end

end

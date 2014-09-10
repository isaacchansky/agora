ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require_relative '../app/app'

include Rack::Test::Methods

def app
  Agora
end


describe Event do
  before do

  end

  it "should return a 200" do
    get "/events"
    last_response.status.must_equal 200
  end

end


describe Source do

  it "should return a 200" do
    get "/events"
    last_response.status.must_equal 200
  end

end

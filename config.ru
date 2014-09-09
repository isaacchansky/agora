require File.join(File.dirname(__FILE__), 'app/app.rb')

map "/public" do
    run Rack::Directory.new("./app/public")
end

run Agora.new

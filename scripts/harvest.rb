require 'icalendar'
require 'http'
require_relative '../app/app.rb'

sources = Source.all


def harvest_events(source)
  puts "\nHarvesting Events from source: \"#{source.name}\" (#{source.url})..."
  response = HTTP.get source.url

  cals = Icalendar.parse response.body
  puts "Found #{cals.count} calendar(s)..."

  cals.each do |cal|
    puts "There are #{cal.events.count} events in this calendar"
    cal.events.each do |event|
      puts "\t#{event.summary}"
      # puts "\t#{event.description}"
    end
  end

end

sources.each do |source|
  harvest_events(source)
end

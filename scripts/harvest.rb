require 'icalendar'
require 'net/http'
require './app/app.rb'

sources = Source.all


def create_or_update_event(uid, attributes)

 # create a new event or update an existing one
  event = Event.first( uid: uid )

  if event
    event.update(attributes)
    puts "Updated #{attributes[:title]}"
  else
    event = Event.create(attributes)
    puts "Created #{attributes[:title]}"
  end

  # save it!
  event.save

end


def harvest_events(source)

  puts "\nHarvesting Events from source: \"#{source.name}\" (#{source.url})..."

  uri = URI source.url
  response = Net::HTTP.get uri
  cals = Icalendar.parse response

  puts "Found #{cals.count} calendar(s)..."

  cals.each do |cal|

    puts "There are #{cal.events.count} events in this calendar"

    cal.events.each do |event|

      puts "\t#{event.summary}"

      attributes = {
        source: source,
        uid: event.uid,
        start_date: event.dtstart,
        end_date: event.dtend,
        title: event.summary,
        description: event.description,
        url: event.url,
        location: event.location
      }

      create_or_update_event(event.uid, attributes)

    end
  end

end



sources.each do |source|
  harvest_events(source)
end

require 'data_mapper'

class Event
  include DataMapper::Resource
  property :id, Serial
  property :created_at, DateTime

  property :start_date, DateTime, :required => true
  property :end_date, DateTime, :required => true

  property :title, String, :required => true
  property :description, Text
  property :pricing, String
  # Contact
  property :contact_email, String
  property :organizer, String
  # Location
  property :location_name, String
  property :location_address, String
  property :location_post_code, String
  property :location_town, String
  property :location_country, String

end

class Source
  include DataMapper::Resource
  property :id, Serial
  property :name, String, :required => true
  property :ical_url, String, :format => :url
end

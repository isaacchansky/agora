require 'data_mapper'

DataMapper::Property::String.length(255)
DataMapper::Model.raise_on_save_failure = true

class Event
  include DataMapper::Resource
  # Meta
  property :id, Serial
  property :created_at, DateTime
  belongs_to :source

  # Basic info
  property :uid, String
  property :start_date, DateTime, :required => true
  property :end_date, DateTime, :required => true
  property :title, String, :required => true
  property :description, Text
  # Resources
  property :url, String
  property :pricing, String
  # Contact
  property :contact_email, String
  property :organizer, String
  # Location
  property :location, String

end

class Source
  include DataMapper::Resource
  has n, :events
  property :id, Serial
  property :name, String, :required => true
  property :type, String, :required => true
  property :url, String, :required => true, :unique => true
end

module Models
  require 'data_mapper'

  class Event
    include DataMapper::Resource
    property :id, Serial
    property :title, String
    property :description, Text
    property :created_at, DateTime
    property :start_date, Date
    property :end_date, Date

  end
end

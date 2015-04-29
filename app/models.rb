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


  def self.full_text_search(query_string, model_attributes)
    # A crude, full text-ish search for events.
    # Parameters:
    #   query_string = basic string, no operators are supported at this time.
    #   model_attributes = array of model attributes as symbols.

    # split up search term into tokens
    search_terms = query_string.split(' ').map{ |q| "%#{q}%" }
    # using ILIKE for better querying.
    operator = "ILIKE"

    num_attr = model_attributes.count

    # build out individual queries "<attribute> <operator> ? "
    # so we can compose a larger query of something like:
    #   title ILIKE ? OR title ILIKE ?
    query_chunks = model_attributes.map{|attr|
      Array.new(search_terms.count){ "#{attr.to_s} #{operator} ?" }.join(' OR ')
    }
    query = [query_chunks.flatten.join(' OR ')].concat( search_terms*num_attr)

    # execute query on events
    Event.all( conditions: query )

  end

end

class Source
  include DataMapper::Resource
  has n, :events
  property :id, Serial
  property :name, String, :required => true
  property :type, String, :required => true
  property :url, String, :required => true, :unique => true
end

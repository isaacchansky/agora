
class Agora < Sinatra::Application

  helpers do
    def simple_date(date)
      date.strftime("%A %B %d, %Y")
    end
  end

end

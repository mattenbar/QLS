class Event
    attr_accessor :date, :genre, :name, :time, :link

     @@all = []
     @events_by_genre = []

    def initialize(event_hash)
        @date = event_hash[:date]
        @genre = event_hash[:genre]
        @name = event_hash[:name]
        @time = event_hash[:time]
        @link = event_hash[:link]
        @@all << self
    end
    
    def self.create_from_collection(events_array = Scraper.scrape_site)
        events_array.each do |event_hash|
         self.new(event_hash)
        end
    end

    def self.all
        @@all
    end
end
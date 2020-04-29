class QuarantineLiveStreams::Event
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
    
    def self.create_from_collection(events_array = QuarantineLiveStreams::Scraper.scrape_site)
        events_array.each do |event_hash|
         self.new(event_hash)
        end
    end

    def self.all
        @@all
    end

    def self.find_by_genre(genre)
        @events_by_genre = []
        QuarantineLiveStreams::Event.all.each do |event_obj|
            if event_obj.genre == genre
                @events_by_genre << event_obj
            end
        end
        @events_by_genre.each_with_index do |event_obj, index|
            puts "#{index + 1}. #{event_obj.name}"
        end
    end

    def self.find_by_date(date)
        @events_by_date = []
        QuarantineLiveStreams::Event.all.each do |event_obj|
            if event_obj.date == date
                @events_by_date << event_obj
            end
        end
        @events_by_date.each_with_index do |event_obj, index|
            puts "#{index + 1}. #{event_obj.name}"
        end
    end
end
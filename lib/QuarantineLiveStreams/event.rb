class QuarantineLiveStreams::Event
    attr_accessor :date, :genre, :name, :time, :link

     @@all = []
     @@events_by_genre = [] 
     @@events_by_date = []
     @@all_dates_array = []

    def initialize(event_hash)
        @date = event_hash[:date]
        @genre = event_hash[:genre]
        @name = event_hash[:name]
        @time = event_hash[:time]
        @link = event_hash[:link]
        @@all << self
    end

    def self.create_from_collection(events_array = nil)
        # Nicer way to allow for an argument with a default that's complex.
        events_array ||= QuarantineLiveStreams::Scraper.scrape_npr
        events_array.each do |event_hash|
         self.new(event_hash)
        end
    end

    def self.all
        @@all
    end

    def self.find_by_genre(genre)
        @@events_by_genre = QuarantineLiveStreams::Event.all.map{|e| e.genre == genre}
    end

    def self.display_by_date(date)
        @@events_by_date = QuarantineLiveStreams::Event.all.map {|e| e.date == date}
    end

    def self.display_all_dates
        self.create_dates_array
        self.print_dates
    end

    def self.create_dates_array
        @@all_dates_array = QuarantineLiveStreams::Event.all.map do |event_obj|
            event_obj.date
        end

        @@all_dates_array = @@all_dates_array.uniq
    end
    
    def self.print_dates
        @@all_dates_array.each_with_index do |date, index|
            puts "#{index + 1}. #{date}"
        end
    end
    
    def self.display_all_event_names
        # This sounds like it should be part of the Event class...
        self.all.each_with_index do |event_obj, index|
            puts "#{index + 1}. #{event_obj.name}"
        end
    end

    def self.all_dates_array
        @@all_dates_array
    end

    def  self.display_all_genres
        self.create_genres_array
        self.print_genres
    end

    def self.print_genres
        @@all_genres_array.each_with_index do |genre, index|
            puts "#{index + 1}. #{genre}"
        end
    end

    def self.create_genres_array
        @@all_genres_array = QuarantineLiveStreams::Event.all.map do |event_obj|
            event_obj.genre
        end

        @@all_genres_array = @@all_genres_array.uniq
    end

    def self.all_genres_array
        @@all_genres_array
    end
end
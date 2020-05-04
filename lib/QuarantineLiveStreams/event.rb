class QuarantineLiveStreams::Event
    attr_accessor :date, :genre, :name, :time, :link

     @@all = []
     @@events_by_genre = [] 
     @@events_by_date = []
     @@all_dates_array = []

    def initialize(event_hash)
        event_hash.each {|key, value| self.send("#{key}=",value)}
        @@all << self
    end

    def self.create_from_collection(events_array = nil)
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

    def self.create_genres_array
        @@all_genres_array = QuarantineLiveStreams::Event.all.map do |event_obj|
            event_obj.genre
        end

        @@all_genres_array = @@all_genres_array.uniq
    end

    def self.all_genres_array
        @@all_genres_array
    end

    def self.all_dates_array
        @@all_dates_array
    end
end
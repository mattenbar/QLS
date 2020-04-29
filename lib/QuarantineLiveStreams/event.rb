class QuarantineLiveStreams::Event
    attr_accessor :date, :genre, :name, :time, :link

     @@all = []
     @events_by_genre = [] # Why is this a class instance variable
                           # and not just a class variable?

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
        events_array ||= QuarantineLiveStreams::Scraper.scrape_site
        events_array.each do |event_hash|
         self.new(event_hash)
        end
    end

    def self.all
        @@all
    end

    def self.find_by_genre(genre)
        @events_by_genre = [] # Why does this need to be an instance variable
                              # Wouldn't a local variable just work?
                              # Why does the class need to remember this 
                              # just to return it?

        # Why not use Ruby's select on an array?
        # QuarantineLiveStreams::Event.all.select{|e| e.genre == genre}
        QuarantineLiveStreams::Event.all.each do |event_obj|
            if event_obj.genre == genre
                @events_by_genre << event_obj
            end
        end

        # This feels like a different method. This is printing them.
        # You should have methods do 1 and only 1 thing.
        @events_by_genre.each_with_index do |event_obj, index|
            puts "#{index + 1}. #{event_obj.name}"
        end
    end

    # Same comments as above.
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
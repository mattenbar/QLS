require "pry"
class QuarantineLiveStreams::CLI


    def call
        make_events
        menu
    end

    def menu
        input = nil
        while input != "exit"
            puts "Welcome to QLS, your source for music live streams during quarantine"
            puts 'Please enter "all" to see a list of all events, "dates" to see a list of dates available, "genres" to see a list of genres available, or "exit"'

            input = gets.strip.downcase

            case input
             when "all"
                puts "Enter the number of the event you would like to see"
                display_all_event_names
                input = gets.strip.to_i
             when "dates"
                puts "please enter a number to see events for that date"
                display_all_dates
             when "genres"
                puts "please enter a number to see events for that genre"
                display_all_genres
             when input.is_a? Intger
                puts
            end
        end
    end

    def make_events
        Event.create_from_collection
    end

    def display_all_event_names
        Event.all.each_with_index do |event_obj, index|
            puts "#{index + 1}. #{event_obj.name}"
        end
    end

    def display_all_dates
        array = Event.all.map do |event_obj|
            event_obj.date
        end
        array = array.uniq
        array.each_with_index do |date, index|
            puts "#{index + 1}. #{date}"
        end
    end

    def  display_all_genres
        array = Event.all.map do |event_obj|
            event_obj.genre.downcase
        end
        array = array.uniq
        array.each_with_index do |genre, index|
            puts "#{index + 1}. #{genre}"
        end
    end
end
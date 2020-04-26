require "pry"
class QuarantineLiveStreams::CLI

    def call
        welcome
        make_events
        menu
        goodbye
    end

    def menu

        input = nil

        while input != "exit"
            puts ""
            puts 'Please enter "all" to see a list of all events,'
            puts '"dates" to see a list of dates available,' 
            puts '"genres" to see a list of genres available, or "exit"'
            puts ""

            input = gets.strip.downcase

            case input
             when "all"

                puts "Enter the number of the event you would like to see or the number 0 to go back to menu"
                display_all_event_names
                all_input = gets.strip.to_i
                
                if all_input > 0 && all_input <= @all_events.length
                    
                    @current_event = @all_events[all_input - 1]
                    
                    puts ""
                    puts "Live Stream: #{@current_event.name}"
                    puts "Genre: #{@current_event.genre}"
                    puts "Date: #{@current_event.date}"
                    puts "Time: #{@current_event.time}"
                    puts "Link: #{@current_event.link}"
                end

             when "dates"

                puts "please enter the number of the date to see events for that date or 0 to go back to main menu"
                display_all_dates #shows all dates
                date_input = gets.strip.to_i #gets what date we want from user

                current_date = @all_dates_array[date_input - 1]

                find_by_date(@all_dates_array.index(current_date)) #searching by string name

                if date_input > 0 && date_input <= @all_dates_array.length
                    @events_by_date = []
                    @all_events.each_with_index do |event_obj, index|
                        if event_obj.date == current_date
                         puts "#{index + 1}. #{event_obj.name}"
                         @events_by_date << event_obj
                        end
                    end
                end

                event_input = gets.strip.to_i
                
                if event_input > 0 && event_input <= @all_events.length
                    @current_event = @all_events[event_input - 1]
                    
                    puts ""
                    puts "Live Stream: #{@current_event.name}"
                    puts "Genre: #{@current_event.genre}"
                    puts "Date: #{@current_event.date}"
                    puts "Time: #{@current_event.time}"
                    puts "Link: #{@current_event.link}"
                end 

             
            when "genres"
                puts "please enter a number to see events for that genre or 0 to go back to main menu"
                display_all_genres
                genre_input = gets.strip.to_i

                current_genre = @all_genres_array[genre_input - 1]

                find_by_genre(@all_genres_array.index(current_genre))
                #binding.pry

                if genre_input > 0 && genre_input <= @all_genres_array.length
                    @events_by_genre = []
                    @all_events.each_with_index do |event_obj, index|
                        #binding.pry
                        if event_obj.genre == current_genre
                         puts "#{index + 1}. #{event_obj.name}"
                         @events_by_genre << event_obj
                        end
                    end
                end

                event_input = gets.strip.to_i

                if event_input > 0 && event_input <= @all_events.length
                    @current_event = @all_events[event_input - 1]
                    
                    puts ""
                    puts "Live Stream: #{@current_event.name}"
                    puts "Genre: #{@current_event.genre}"
                    puts "Date: #{@current_event.date}"
                    puts "Time: #{@current_event.time}"
                    puts "Link: #{@current_event.link}"
                end 
            end
        end
    end

    def make_events
        Event.create_from_collection
        @all_events = Event.all
    end

    def display_all_event_names
        Event.all.each_with_index do |event_obj, index|
            puts "#{index + 1}. #{event_obj.name}"
        end
    end

    def display_all_dates
        @all_dates_array = []

        Event.all.each do |event_obj|
            @all_dates_array << event_obj.date
        end

        @all_dates_array = @all_dates_array.uniq
        @all_dates_array.each_with_index do |date, index|
            puts "#{index + 1}. #{date}"
        end
    end

    def  display_all_genres
        @all_genres_array = []

        Event.all.each do |event_obj|
            @all_genres_array << event_obj.genre
        end

        @all_genres_array = @all_genres_array.uniq
        @all_genres_array.each_with_index do |genre, index|
            puts "#{index + 1}. #{genre}"
        end
    end

    def find_by_genre(genre)
        @events_by_genre = []
        Event.all.map do |event_obj|
            if event_obj.genre == genre
                @events_by_genre << event_obj
            end
        end
        @events_by_genre.each_with_index do |event_obj, index|
            puts "#{index + 1}. #{event_obj.name}"
        end
    end

    def find_by_date(date)
        @events_by_date = []
        Event.all.map do |event_obj|
            if event_obj.date == date
                @events_by_date << event_obj
            end
        end
        @events_by_date.each_with_index do |event_obj, index|
            puts "#{index + 1}. #{event_obj.name}"
        end
    end

    def welcome
        puts ""
        puts "|******************************|"
        puts "|        WELCOME TO:           |"
        puts "|                              |"
        puts "|         ╭━━┳╮╭━━╮            |"
        puts "|         ┃╭╮┃┃┃━━┫            |"
        puts "|         ┃╰╯┃╰╋━━┃            |"
        puts "|         ╰━╮┣━┻━━╯            |"
        puts "|         ╱╱╰╯                 |"
        puts "|                              |"
        puts "|   Quarantine Live Streams    |"
        puts "|******************************|"
        puts ""
    end

    def goodbye
        puts ""
        puts "|******************************|"
        puts "|   Quarantine Live Streams    |"
        puts "|                              |"
        puts "|         ╭━━┳╮╭━━╮            |"
        puts "|         ┃╭╮┃┃┃━━┫            |"
        puts "|         ┃╰╯┃╰╋━━┃            |"
        puts "|         ╰━╮┣━┻━━╯            |"
        puts "|         ╱╱╰╯                 |"
        puts "|                              |"
        puts "|    Thanks for listening      |"
        puts "|******************************|"
        puts ""
    end
end
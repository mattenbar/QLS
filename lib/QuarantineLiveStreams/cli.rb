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
                all
             when "dates"
                dates
             when "genres"
                genres  
            end
        end
    end

    def all
        puts ""
        puts "Enter the number of the event you would like to see,"
        puts "or 0 to go back to menu"
        print_all_event_names
        puts ""
        puts "Enter the number of the event you would like to see,"
        puts "or 0 to go back to menu"
        puts ""
        all_input = gets.strip.to_i
                
        if all_input > 0 && all_input <= QuarantineLiveStreams::Event.all.length
                    
            current_event = QuarantineLiveStreams::Event.all[all_input - 1]
                    
            puts ""
            puts "Live Stream: #{current_event.name}"
            puts "Genre: #{current_event.genre}"
            puts "Date: #{current_event.date}"
            puts "Time: #{current_event.time} ET."
            puts "Link: #{current_event.link.colorize(:green)}"
            puts ""
        end
    end

    def dates           
        puts ""
        QuarantineLiveStreams::Event.create_dates_array
        print_dates
        puts ""
        puts "Please enter the number for the date to see events for that date,"
        puts "or 0 to go back to main menu"
        puts ""
        date_input = gets.strip.to_i 
        puts ""
                

        current_date = QuarantineLiveStreams::Event.all_dates_array[date_input - 1] 

        QuarantineLiveStreams::Event.display_by_date(QuarantineLiveStreams::Event.all_dates_array.index(current_date)) 

        if date_input > 0 && date_input <= QuarantineLiveStreams::Event.all_dates_array.length
            @events_by_date = QuarantineLiveStreams::Event.all.each_with_index do |event_obj, index|
                if event_obj.date == current_date
                    puts "#{index + 1}. #{event_obj.name}"
                    event_obj
                    end
                end

            puts ""
            puts "Please enter the number of the event you would like more info about,"
            puts "or 0 to return to main menu"
            puts ""
            event_input = gets.strip.to_i
            puts ""
                    
                
            if event_input > 0 && event_input <= QuarantineLiveStreams::Event.all.length
                        @current_event = QuarantineLiveStreams::Event.all[event_input - 1]

                puts "Live Stream: #{@current_event.name}"
                puts "Genre: #{@current_event.genre}"
                puts "Date: #{@current_event.date}"
                puts "Time: #{@current_event.time} ET."
                puts "Link: #{@current_event.link.colorize(:green)}"
            end 
        end
    end

    def genres           
        puts ""
        QuarantineLiveStreams::Event.create_genres_array
        print_genres
        puts ""
        puts "please enter the number of the genre you would like to see events for," 
        puts "or 0 to go back to main menu"
        puts ""
        genre_input = gets.strip.to_i
        puts ""

        current_genre = QuarantineLiveStreams::Event.all_genres_array[genre_input - 1]
        QuarantineLiveStreams::Event.find_by_genre(QuarantineLiveStreams::Event.all_genres_array.index(current_genre))
                

        if genre_input > 0 && genre_input <= QuarantineLiveStreams::Event.all_genres_array.length
            @events_by_genre = QuarantineLiveStreams::Event.all.each_with_index do |event_obj, index|
                if event_obj.genre == current_genre
                    puts "#{index + 1}. #{event_obj.name}"
                    event_obj
                    end
                end
                    
            puts ""
            puts "Please enter the number of the event you would like more info about"
            puts "or 0 to go back to main menu"
            puts ""
            event_input = gets.strip.to_i
            puts ""

            if event_input > 0 && event_input <= QuarantineLiveStreams::Event.all.length
                current_event = QuarantineLiveStreams::Event.all[event_input - 1]
                        
                puts "Live Stream: #{current_event.name}"
                puts "Genre: #{current_event.genre}"
                puts "Date: #{current_event.date}"
                puts "Time: #{current_event.time} ET."
                puts "Link: #{current_event.link.colorize(:green)}"
            end
        end  
    end

    def make_events
        QuarantineLiveStreams::Event.create_from_collection
    end

    def welcome
        puts ""
        puts "|******************************|".colorize(:light_blue)
        puts "|        WELCOME TO:           |".colorize(:light_blue)
        puts "|                              |".colorize(:light_blue)
        puts "|         ╭━━┳╮╭━━╮            |".colorize(:light_blue)
        puts "|         ┃╭╮┃┃┃━━┫            |".colorize(:light_blue)
        puts "|         ┃╰╯┃╰╋━━┃            |".colorize(:light_blue)
        puts "|         ╰━╮┣━┻━━╯            |".colorize(:light_blue)
        puts "|         ╱╱╰╯                 |".colorize(:light_blue)
        puts "|                              |".colorize(:light_blue)
        puts "|   Quarantine Live Streams    |".colorize(:light_blue)
        puts "|******************************|".colorize(:light_blue)
        puts ""
    end

    def goodbye
        puts ""
        puts "|******************************|".colorize(:light_blue)
        puts "|   Quarantine Live Streams    |".colorize(:light_blue)
        puts "|                              |".colorize(:light_blue)
        puts "|         ╭━━┳╮╭━━╮            |".colorize(:light_blue)
        puts "|         ┃╭╮┃┃┃━━┫            |".colorize(:light_blue)
        puts "|         ┃╰╯┃╰╋━━┃            |".colorize(:light_blue)
        puts "|         ╰━╮┣━┻━━╯            |".colorize(:light_blue)
        puts "|         ╱╱╰╯                 |".colorize(:light_blue)
        puts "|                              |".colorize(:light_blue)
        puts "|    Thanks for listening      |".colorize(:light_blue)
        puts "|******************************|".colorize(:light_blue)
        puts ""
    end

    def print_genres
        QuarantineLiveStreams::Event.all_genres_array.each_with_index do |genre, index|
            puts "#{index + 1}. #{genre}"
        end
    end

    def print_all_event_names
        QuarantineLiveStreams::Event.all.each_with_index do |event_obj, index|
            puts "#{index + 1}. #{event_obj.name}"
        end
    end

    def print_dates
        QuarantineLiveStreams::Event.all_dates_array.each_with_index do |date, index|
            puts "#{index + 1}. #{date}"
        end
    end
end
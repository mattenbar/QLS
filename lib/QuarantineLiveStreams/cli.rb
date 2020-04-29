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
                # instead of having all the code for the "all" action here
                # why not break it out into it's own method?
                puts ""
                puts "Enter the number of the event you would like to see,"
                puts "or 0 to go back to menu"
                display_all_event_names
                puts ""
                puts "Enter the number of the event you would like to see,"
                puts "or 0 to go back to menu"
                puts ""
                all_input = gets.strip.to_i
                
                if all_input > 0 && all_input <= QuarantineLiveStreams::Event.all.length
                    
                    @current_event = QuarantineLiveStreams::Event.all[all_input - 1]
                    
                    puts ""
                    puts "Live Stream: #{@current_event.name}"
                    puts "Genre: #{@current_event.genre}"
                    puts "Date: #{@current_event.date}"
                    puts "Time: #{@current_event.time} ET."
                    puts "Link: #{@current_event.link.colorize(:green)}"
                    puts ""
                end

             when "dates"
                # instead of having all the code for the "dates" action here
                # why not break it out into it's own method?              
                puts ""
                display_all_dates #shows all dates
                puts ""
                puts "Please enter the number for the date to see events for that date,"
                puts "or 0 to go back to main menu"
                puts ""
                date_input = gets.strip.to_i #gets what date we want from user
                puts ""
                

                current_date = @all_dates_array[date_input - 1] 

                QuarantineLiveStreams::Event.find_by_date(@all_dates_array.index(current_date)) #searching by string name

                if date_input > 0 && date_input <= @all_dates_array.length
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

            when "genres"
                # instead of having all the code for the "genres" action here
                # why not break it out into it's own method?              
                puts ""
                
                display_all_genres
                puts ""
                puts "please enter the number of the genre you would like to see events for," 
                puts "or 0 to go back to main menu"
                puts ""
                genre_input = gets.strip.to_i
                puts ""

                current_genre = @all_genres_array[genre_input - 1]
                QuarantineLiveStreams::Event.find_by_genre(@all_genres_array.index(current_genre))
                

                if genre_input > 0 && genre_input <= @all_genres_array.length
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
                        @current_event = QuarantineLiveStreams::Event.all[event_input - 1]
                        
                        puts "Live Stream: #{@current_event.name}"
                        puts "Genre: #{@current_event.genre}"
                        puts "Date: #{@current_event.date}"
                        puts "Time: #{@current_event.time} ET."
                        puts "Link: #{@current_event.link.colorize(:green)}"
                    end
                end    
            end
        end
    end

    def make_events
        # Let's talk about memoization
        QuarantineLiveStreams::Event.create_from_collection
    end

    def display_all_event_names
        # This sounds like it should be part of the Event class...
        QuarantineLiveStreams::Event.all.each_with_index do |event_obj, index|
            puts "#{index + 1}. #{event_obj.name}"
        end
    end

    def display_all_dates
        # This also
        @all_dates_array = QuarantineLiveStreams::Event.all.map do |event_obj|
            event_obj.date
        end

        @all_dates_array = @all_dates_array.uniq
        @all_dates_array.each_with_index do |date, index|
            puts "#{index + 1}. #{date}"
        end
    end

    def  display_all_genres
        # Same
        @all_genres_array = QuarantineLiveStreams::Event.all.map do |event_obj|
            event_obj.genre
        end

        @all_genres_array = @all_genres_array.uniq
        @all_genres_array.each_with_index do |genre, index|
            puts "#{index + 1}. #{genre}"
        end
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
end
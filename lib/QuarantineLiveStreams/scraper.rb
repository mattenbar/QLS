require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

    def self.scrape_site
        events_array = []
        url = "https://www.npr.org/2020/03/17/816504058/a-list-of-live-virtual-concerts-to-watch-during-the-coronavirus-shutdown"
        doc = Nokogiri::HTML(open(url))
        content = doc.css(".storytext")
        
        found = false
        event_hash = {}

        content.children.each do |el|
            
            if (el.name == 'h3')
                found = true
            end
            
            if ((el.name == 'h3' || el.name == 'p' || el.name == 'h6') && found)
                found = true
                
                case el.name                   
                    when 'h3'
                        #binding.pry
                        date = event_hash[:date] = el.text
                    when 'h6'
                        genre = event_hash[:genre] = el.text
                    when 'p'
                        # event_hash[:date] = date
                        # event_hash[:genre] = genre
                        event_hash[:name] = el.css('strong').text
                        time = el.text.gsub(/.*?(?=Time)/im, "")
                        event_hash[:time] = time = time.slice(0..(time.index('. ETL')))
                        if event_hash[:link] = el.css('a').attr('href')
                        event_hash[:link] = el.css('a').attr('href').value
                        end
                        events_array << event_hash
                end
            end
        end
        puts events_array
    end
end
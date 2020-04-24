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
        events_array = []

        event_obj = {}

        content.children.each do |el|
            if (el.name == 'h3')
                found = true
            end
            
            if ((el.name == 'h3' || el.name == 'p' || el.name == 'h6') && found)
                found = true
                
                case el.name                   
                    when 'h3'
                        event_obj = {}
                        event_obj[:date] = el.text
                    when 'h6'
                        event_obj[:genre] = el.text
                    when 'p'
                        event_obj[:name] = el.css('strong').text
                        if event_obj[:time] = el.text.include?("Time")
                            event_obj[:time] = el.css()
                        end
                        binding.pry
                        event_obj[:link] = el.css('href')
                end
            end
        end

    end
end
class QuarantineLiveStreams::Scraper
    @events_array = [] # Not sure if you need these class instance variables.
                       # Let's go over them.
    
    def self.scrape_npr
        url = "https://www.npr.org/2020/03/17/816504058/a-list-of-live-virtual-concerts-to-watch-during-the-coronavirus-shutdown"
        doc = Nokogiri::HTML(open(url))
        content = doc.css(".storytext")
        found = false
        date = "test"  
        genre = "test"
        # This is pretty messy but scraping always is but this could probably be
        # cleaned up a ton if I looked at the page.
        content.children.each do |el|
            if (el.name == 'h3')
                found = true
            end
            if ((el.name == 'h3' || el.name == 'p' || el.name == 'h6') && found)
                found = true
                case el.name
                    when 'h3'
                        date = el.text        
                    when 'h6'
                        genre = el.text
                    when 'p'
                        event_hash = {}
                        event_hash[:date] = date
                        event_hash[:genre] = genre.downcase
                        event_hash[:name] = el.css('strong').text
                        time = el.text.gsub(/.*?(?=Time)/im, "")
                        event_hash[:time] = time = time.slice(0..(time.index('. ETL')))
                        if event_hash[:link] = el.css('a').attr('href')
                        # INDENT
                            event_hash[:link] = el.css('a').attr('href').value
                        end
                        @events_array << event_hash
                end
            end
        end
        @events_array
    end
end
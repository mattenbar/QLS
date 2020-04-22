require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

    def self.scrape_site
        events_array = []
        url = "https://www.npr.org/2020/03/17/816504058/a-list-of-live-virtual-concerts-to-watch-during-the-coronavirus-shutdown"
        doc = Nokogiri::HTML(open(url))
        doc.css(".edTag").css("h3").each do |tag|
            events_array << tag.text
        end
        binding.pry
        events_array
    end

end
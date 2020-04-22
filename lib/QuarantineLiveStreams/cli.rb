require "pry"
class QuarantineLiveStreams::CLI

    def call
        puts "hello"
        Scraper.scrape_site
    end
end

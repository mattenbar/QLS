# Require Gems First
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'colorize'

require_relative "./QuarantineLiveStreams/version"
require_relative "./QuarantineLiveStreams/cli"
require_relative "./QuarantineLiveStreams/scraper"
require_relative "./QuarantineLiveStreams/event"

module QuarantineLiveStreams
end
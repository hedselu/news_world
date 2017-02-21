require_relative 'models/rss_feed'
require 'open-uri'
require 'rss'

class RSSReader
  attr_accessor :feeds

  def initialize
    @feeds = []
  end

  def read(source, url, category)
    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.channel.items.each do |item|
        @feeds << RSSFeed.new(source, category, item.title,
                              item.description, item.date, item.link)
      end
    end
  end

  def descriptions_parse
    @feeds.each { |feed| feed.description.sub!(/<div(.|\n|\r)*/, '') }
  end
end

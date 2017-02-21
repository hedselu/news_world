require_relative 'news_parser'
require_relative 'rss_reader'
require_relative 'models/news'
require_relative 'models/category'
require_relative 'config/config_loader'
require_relative 'config/database_connector'

def create_category(name)
  Category.find_by_name(name) || Category.create(name: name)
end

def parse_news(feeds)
  feeds.each do |feed|
    begin
      news_parser = NewsParser.new(feed.link)
      news_parser.read
      if News.find_by_title(feed.title).nil?
        news = News.new(title: feed.title,
                        description: feed.description, text: news_parser.text,
                        source: feed.source, image_url: news_parser.image_url, publish_date: feed.date,
                        keywords: news_parser.keywords)
      else
        next
      end
      news.category = create_category(feed.category)
      news.save
    rescue => e
      puts e
      exit
    end
  end
end

def fetch_rss(rss_info)
  rss_reader = RSSReader.new
  begin
    rss_reader.read(rss_info[:source], rss_info[:url], rss_info[:category])
    rss_reader.descriptions_parse
  rescue => e
    puts e
    exit
  end
  rss_reader
end

config = ConfigLoader.new

config.data.each do |rss_info|
  rss = fetch_rss(rss_info)
  parse_news(rss.feeds)
end

require 'nokogiri'
require 'open-uri'

class NewsParser
  attr_accessor :text, :image_url, :keywords

  def initialize(url)
    @url = url
    @text = String.new
    @keywords = String.new
  end

  def read
    verify_url
    fetch_document
    parse_text
    parse_keywords
    parse_image_link
  end

  private

  def verify_url
    uri = URI(@url)
    response = Net::HTTP.start(uri.host, uri.port) { |http| http.get(uri) }
    @url = redirected_uri(response) if redirected?(response)
  end

  def redirected?(response)
    response.class == Net::HTTPMovedPermanently ? true : false
  end

  def redirected_uri(response)
    response['location']
  end

  def fetch_document
    @document = Nokogiri::HTML(open(@url))
  end

  def parse_text
    @document.css('span#articleText p').each do |para|
      @text << "#{para.content}\n"
    end
  end

  def parse_keywords
    keywords_stringed = @document.search("meta[name='keywords']").first['content']
    keywords_stringed.gsub!(/s+/, '')
    @keywords = keywords_stringed.split(/,|\//)
    @keywords.map! { |keyword| keyword.gsub(/^\s+|\s+$/, '').capitalize }
  end

  def parse_image_link
    image_section = @document.css('div.reuters-share.reuters-share-color').first['data-share-img']
    @image_url = image_section
  end
end

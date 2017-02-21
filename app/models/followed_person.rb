class FollowedPerson < ActiveRecord::Base
  belongs_to :profession
  has_and_belongs_to_many :users
  has_and_belongs_to_many :news

  before_save :capitalize_names
  before_save :scan_for_person

  private

  def capitalize_names
    first_name.capitalize
    second_name.capitalize
  end

  def scan_for_person
    all_news = News.all
    news_with_name = []
    news_matched = []
    resources = %i(keywords title text)
    resources.each { |resource| news_with_name.concat(scan(all_news, resource, :name)) }
    resources.each { |resource| news_matched.concat(scan(news_with_name, resource, :profession)) }
    self.news = news_matched
  end

  def scan(news, target_resource, target_attribute)
    news.select do |article|
      resource_to_scan = retrieve_resource(target_resource, article)
      if target_attribute == :profession
        matches?(resource_to_scan, profession)
      else
        resource_to_scan.include?(first_name) && resource_to_scan.include?(second_name)
      end
    end
  end

  def retrieve_resource(target_resource, article)
    case target_resource
    when :keywords then
      article.keywords
    when :title then
      split_words(article.title)
    when :text then
      split_words(article.text)
    else
      []
    end
  end

  def split_words(text)
    words = text.split(/!|\.|\?|\s+/)
    words.delete_if(&:empty?)
    words.map!(&:capitalize)
  end

  def matches?(words, target_word)
    words.each do |word|
      count = 0
      0..word.length do |index|
        count += 1 if word[index] == target_word[index]
      end
      percentage = (count.to_f / words.length.to_f) * 100
      return true if percentage > 0.75
    end
  end
end

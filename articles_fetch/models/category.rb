require 'active_record'

class Category < ActiveRecord::Base
  has_many :news
  validates_uniqueness_of :name
end

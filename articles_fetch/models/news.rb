require 'active_record'

class News < ActiveRecord::Base
  belongs_to :category
end

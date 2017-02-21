class News < ActiveRecord::Base
  belongs_to :category
  has_and_belongs_to_many :followed_people

  Array.include CoreExtensions::Array::NewsSort
end

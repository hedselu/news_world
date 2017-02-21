class Profession < ActiveRecord::Base
  has_many :followed_person

  before_save :capitalize_name

  def capitalize_name
    name.capitalize
  end
end

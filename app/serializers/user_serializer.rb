class UserSerializer < ActiveModel::Serializer
  attributes :id, :login, :email
  has_many :categories
end

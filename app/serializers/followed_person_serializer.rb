class FollowedPersonSerializer < ActiveModel::Serializer
  attributes :first_name, :second_name, :id
  has_one :profession
end

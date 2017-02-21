class NewsSerializer < ActiveModel::Serializer
  attributes :title, :text, :description, :id, :image_url,
             :source, :publish_date, :down_votes, :up_votes, :voted
  has_one :category

  def filter(keys)
    keys.delete :voted unless scope
    keys
  end

  def voted
    Vote.where('news_id=? AND user_id=?', id, scope.id).to_a.first.try(:value)
  end
end

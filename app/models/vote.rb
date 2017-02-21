class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :news

  validates_uniqueness_of :user_id, scope: :news_id
  validate :value_differs, on: :update

  after_create :commit_new
  after_update :commit_persisted

  def commit_new
    value ? news.increment(:up_votes, 1) : news.increment(:down_votes, 1)
    news.save
  end

  def commit_persisted
    if value
      news.increment(:up_votes, 1)
      news.decrement(:down_votes, 1)
    else
      news.increment(:down_votes, 1)
      news.decrement(:up_votes, 1)
    end
    news.save
  end

  def value_differs
    errors.add(:value, 'not changed') unless value_changed?
  end
end

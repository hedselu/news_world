class Session < ActiveRecord::Base
  belongs_to :user

  def restore
    self.expiration = Time.zone.now + 24.hours
    self.token = SecureRandom.uuid
    self
  end

  def expire!
    self.expiration = Time.zone.now
  end

  def refresh!
    self.expiration = Time.zone.now + 24.hours
  end

  def expired?
    expiration < Time.zone.now
  end
end

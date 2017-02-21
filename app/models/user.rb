class User < ActiveRecord::Base
  has_secure_password validations: false

  has_one :session
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :followed_people
  accepts_nested_attributes_for :session

  validates :login, length: { minimum: 6 }, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /@/ }
  validates :password, confirmation: true, length: { minimum: 8 }, format: { with: /.*[a-z][0-9]{2,}/ },
                       presence: true, on: :create

  def self.find_by_token(token)
    session = Session.find_by_token(token)
    session.user if session
  end

  def new_session!
    self.session = session.blank? ? Session.new.restore : session.restore
    save
  end

  def refresh_session!
    raise Errors::SessionError if session.expired?
    session.refresh!
    save
  end

  def expire_session!
    session.expire!
    save
  end

  def admin?
    role == 'admin'
  end

  def guest?
    new_record?
  end
end

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      admin_abilities
    elsif user.guest?
      guest_abilities
    else
      user_abilities
    end
  end

  def admin_abilities
    can %i(create destroy), Session
    can %i(read destroy), User
    can %i(read destroy), News
  end

  def user_abilities
    can %i(create update), Vote
    can %i(create destroy), Session
    can %i(read), News
    can :manage, FollowedPerson
    can :create, :user_password
    can :read, %i(user_top_news user_category_news user_followed_people_news)
    can %i(show update), :user_account
  end

  def guest_abilities
    can :create, User
    can :create, Session
    can :read, News
  end
end

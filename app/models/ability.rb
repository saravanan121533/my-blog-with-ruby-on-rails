class Ability
  include CanCan::Ability

  def initialize(user)

    # user here is essentially current_user and it may be nil
    # we set it to User.new if it's nil:
    user ||= User.new

    # This will make the user an ability to perform actions for Post:
    # new, edit, update, destroy, show
    can :manage, Post do |post|
      user == post.user
    end

    can :manage, Comment do |comment|
      user == comment.user
    end

    can :destroy, Comment do |comment|
      user == comment.post.user
    end

  end
end

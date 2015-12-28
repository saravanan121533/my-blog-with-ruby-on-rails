class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

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

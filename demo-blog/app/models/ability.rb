# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user # If the user is not logged in, they have no abilities

    can [:read, :create], Post # All users can read posts

    if user.role == "admin"
      can :manage, Post # Admins can manage (create, read, update, delete) any post
    else
      can :delete, Post, author_id: user.id # Users can only delete their own posts
    end
  end
end

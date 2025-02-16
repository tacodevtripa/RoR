# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user # If the user is not logged in, they have no abilities

    can [ :read, :create, :show_comments ], Post # All users can read and create posts
    can [ :read, :create ], Comment # All users can read and create comments

    if user.role == "admin"
      can :manage, Post # Admins can manage (create, read, update, delete) any post
      can :manage, Comment # Admins can manage (create, read, update, delete) any comment
    else
      can :delete, Post, author_id: user.id # Users can only delete their own posts
      can :delete, Comment, user_id: user.id # Users can only delete their own comments
    end
  end
end

class Ability
  include CanCan::Ability

  def initialize user
    return if user.blank?
    alias_action :answers, :questions, :tags, :tagged, to: :read
    cannot :read, Post, Post, &:answer?
    can :read, [User, Tag, Post]
    can %i(upvote downvote), Post
    can %i(create update destroy), Post, Post do |post|
      post.question? ? (post.owner_user_id == user.id) : (post.question.owner_user_id != user.id)
    end
    can :update, User, id: user.id
    can :create, [Vote, Comment]
    can %i(update destroy), [Vote, Comment], user_id: user.id
  end
end

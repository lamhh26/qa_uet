class Vote < ApplicationRecord
  belongs_to :post
  belongs_to :user

  enum vote_type: {down_mod: -1, up_mod: 1}

  validates :post, inclusion: {
    in: proc do |object|
      object.post ? Post.of_courses(object.user.courses) : []
    end
  }, presence: true
  validates :user, presence: true
  validate :user_vote

  private

  def user_vote
    return unless user && post
    errors.add(:vote, "You cannot vote your own #{post.post_type}") if user == post.owner_user
    vote = post.vote_by user
    return unless vote.persisted?
    errors.add(:vote, "You cannot upvote more") if vote.up_mod? == up_mod?
    errors.add(:vote, "You cannot downvote more") if vote.down_mod? == down_mod?
  end
end

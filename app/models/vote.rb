class Vote < ApplicationRecord
  belongs_to :post
  belongs_to :user

  enum vote_type: {down_mod: -1, up_mod: 1}

  validate :user_vote

  private

  def user_vote
    errors.add(:vote, "You cannot vote your own #{post.post_type}") if user == post.owner_user
    vote = post.vote_by user
    return unless vote.persisted?
    errors.add(:vote, "You cannot upvote more") if vote.up_mod? == self.up_mod?
    errors.add(:vote, "You cannot downvote more") if vote.down_mod? == self.down_mod?
  end
end

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

  scope :newest, ->{order created_at: :desc}
  scope :of_courses, ->(posts){where post_id: posts.ids}

  private

  def user_vote
    return unless user && post
    errors.add(:vote, "You cannot vote your own #{post.post_type}") if user == post.owner_user
    user_vote_value = post.vote_value_by user
    return if user_vote_value == 0
    errors.add(:vote, "You cannot upvote more") if user_vote_value == 1 && up_mod?
    errors.add(:vote, "You cannot downvote more") if user_vote_value == -1 && down_mod?
  end
end

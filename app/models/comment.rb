class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  acts_as_notifiable :users, targets: ->(comment, key) {[comment.post.owner_user]},
    tracked: {only: %i(create)}, notifiable_path: :comment_notifiable_path

  validates :text, length: {minimum: Settings.comment.text.minimum_length,
                            maximum: Settings.comment.text.maximum_length}

  scope :of_courses, ->(posts){where post_id: posts}

  def comment_notifiable_path
    question_path(post.question || post, anchor: "comment-#{id}")
  end
end

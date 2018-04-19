class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :text, length: {minimum: Settings.comment.text.minimum_length,
                            maximum: Settings.comment.text.maximum_length}

  scope :of_courses, ->(posts){where post_id: posts}
end

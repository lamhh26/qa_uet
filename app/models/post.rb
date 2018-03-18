class Post < ApplicationRecord
  belongs_to :owner_user, class_name: User.name
  belongs_to :parent, class_name: Post.name, optional: true
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :comments
  has_many :votes

  enum post_type: {question: 0, answer: 1}
end

class Post < ApplicationRecord
  is_impressionable

  belongs_to :owner_user, class_name: User.name
  belongs_to :question, class_name: Post.name, optional: true, foreign_key: :parent_id
  has_many :answers, class_name: Post.name, foreign_key: :parent_id
  counter_culture :question, column_name: proc{|model| model.answer? ? "answers_count" : nil}
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :comments
  has_many :votes

  enum post_type: {question: 0, answer: 1}

  scope :load_votes, (-> do
    left_outer_joins(:votes).group(:id).select("posts.*, SUM(votes.vote_type) AS vote_count")
  end)
  scope :newest, ->{order created_at: :desc}
  scope :votes, (-> do
    order "vote_count DESC"
  end)
  scope :most_answers, ->{order answers_count: :desc}
  scope :this_week, ->{where "posts.created_at BETWEEN DATE_SUB(NOW(), INTERVAL 1 WEEK) AND NOW()"}
  scope :this_month, ->{where "posts.created_at BETWEEN DATE_SUB(NOW(), INTERVAL 1 MONTH) AND NOW()"}
  scope :unanswered, ->{where answers_count: 0}
  scope :load_tag_by_name, ->(tag_name){joins(:tags).where tags: {name: tag_name}}
end

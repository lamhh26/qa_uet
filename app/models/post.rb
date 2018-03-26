class Post < ApplicationRecord
  is_impressionable counter_cache: true, column_name: :views_count

  belongs_to :owner_user, class_name: User.name
  belongs_to :question, class_name: Post.name, optional: true, foreign_key: :parent_id
  has_many :answers, class_name: Post.name, foreign_key: :parent_id
  counter_culture :question, column_name: proc{|model| model.answer? ? "answers_count" : nil}
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :comments
  has_many :votes

  enum post_type: {question: 0, answer: 1}

  validates :title, length: {minimum: Settings.post.title.minimum_length, maximum: Settings.post.title.maximum_length}
  validates :body, presence: true
  validate :validate_tags

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.pluck(:name).join ", "
  end

  scope :load_votes, (-> do
    left_outer_joins(:votes).group(:id).select("posts.*, SUM(votes.vote_type) AS vote_count")
  end)
  scope :newest, ->{order created_at: :desc}
  scope :oldest, ->{order created_at: :asc}
  scope :votes, (-> do
    order "vote_count DESC"
  end)
  scope :most_answers, ->{order answers_count: :desc}
  scope :viewest, ->{order views_count: :desc}
  scope :hot, ->{where "posts.created_at BETWEEN DATE_SUB(NOW(), INTERVAL 3 DAY) AND NOW()"}
  scope :this_week, ->{where "posts.created_at BETWEEN DATE_SUB(NOW(), INTERVAL 1 WEEK) AND NOW()"}
  scope :this_month, ->{where "posts.created_at BETWEEN DATE_SUB(NOW(), INTERVAL 1 MONTH) AND NOW()"}
  scope :unanswered, ->{where answers_count: 0}
  scope :load_tag_by_name, ->(tag_name){joins(:tags).where tags: {name: tag_name}}

  private

  def validate_tags
    errors.add(:tags, "is at least one") if tags.size < Settings.tag.amount.minimum
    errors.add(:tags, "is too many") if tags.size > Settings.tag.amount.maximum
  end
end

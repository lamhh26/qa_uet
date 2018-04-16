class Post < ApplicationRecord
  is_impressionable counter_cache: true, column_name: :views_count

  before_validation :assign_answer_type, if: proc{|post| post.question.present?}
  before_validation :assign_course, if: proc{|post| post.answer?}
  before_save :make_answer_tags, if: proc{|post| post.answer?}

  belongs_to :owner_user, class_name: User.name
  belongs_to :question, class_name: Post.name, optional: true, foreign_key: :parent_id
  belongs_to :course, optional: true
  has_many :answers, class_name: Post.name, foreign_key: :parent_id, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  counter_culture :question, column_name: proc{|model| model.answer? ? "answers_count" : nil}

  enum post_type: {question: 0, answer: 1}

  validates :owner_user, presence: true
  validates :body, presence: true, length: {minimum: Settings.post.body.minimum_length}
  validates :course, inclusion: {
    in: proc do |object|
      object.owner_user ? object.owner_user.courses : []
    end
  }, presence: true
  with_options if: :question? do
    validates :title, presence: true, length: {minimum: Settings.post.title.minimum_length,
                                               maximum: Settings.post.title.maximum_length}
    validate :validate_tags
  end
  validates :question, presence: true, if: :answer?

  def all_tags= names
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    tags.pluck(:name).join ", "
  end

  def vote_by user
    votes.merge(user.votes).first || votes.build(user: user)
  end

  scope :load_votes, ->{left_outer_joins(:votes).group :id}
  scope :select_posts_votes, ->{select "posts.*, IFNULL(SUM(votes.vote_type), 0) AS vote_count"}
  scope :select_votes, ->{select "IFNULL(SUM(votes.vote_type), 0) AS vote_count"}
  scope :select_id_votes, ->{select("posts.id, IFNULL(SUM(votes.vote_type), 0) AS vote_count")}
  scope :newest, ->{order created_at: :desc}
  scope :oldest, ->{order created_at: :asc}
  scope :votest, ->{order "vote_count DESC"}
  scope :most_answers, ->{order answers_count: :desc}
  scope :viewest, ->{order views_count: :desc}
  scope :hot, ->{where "posts.created_at BETWEEN DATE_SUB(NOW(), INTERVAL 3 DAY) AND NOW()"}
  scope :this_week, ->{where "posts.created_at BETWEEN DATE_SUB(NOW(), INTERVAL 1 WEEK) AND NOW()"}
  scope :this_month, ->{where "posts.created_at BETWEEN DATE_SUB(NOW(), INTERVAL 1 MONTH) AND NOW()"}
  scope :unanswered, ->{where answers_count: 0}
  scope :load_tag_by_name, ->(tag_name){joins(post_tags: :tag).where tags: {name: tag_name}}
  scope :related_questions, (->(question) do
    joins(:tags).where.not(id: question).where tags: {name: question.tags.pluck(:name)}
  end)
  scope :sort_by_tag_name, ->{order "tags.name"}
  scope :of_courses, ->(courses){where course: courses}

  private

  def validate_tags
    errors.add(:tags, "is at least one") if tags.size < Settings.tag.amount.minimum
    errors.add(:tags, "is too many") if tags.size > Settings.tag.amount.maximum
  end

  def make_answer_tags
    self.tags = question.tags
  end

  def assign_course
    self.course = question.course
  end

  def assign_answer_type
    self.post_type = :answer
  end
end

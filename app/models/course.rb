class Course < ApplicationRecord
  belongs_to :course_category
  has_many :posts
  has_many :user_courses
  has_many :users, through: :user_courses

  validates :name, presence: true
  validates :code, uniqueness: {scope: :course_category}, presence: true

  scope :newest, ->{left_outer_joins(:course_category).merge CourseCategory.newest}
  scope :load_posts, (-> do
    left_outer_joins(:posts).select("courses.*, SUM(posts.answers_count) AS course_answers_count,
      COUNT(*) AS posts_count").group "courses.id"
  end)
end

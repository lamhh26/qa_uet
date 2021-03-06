class User < ApplicationRecord
  acts_as_target

  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, foreign_key: :owner_user_id, dependent: :destroy
  has_many :comments
  has_many :votes, dependent: :destroy
  has_many :voted_posts, through: :votes, source: :post
  has_many :answers, through: :posts, source: :answers
  has_many :user_courses, dependent: :destroy
  has_many :courses, through: :user_courses
  has_many :best_answers, ->{answer.best_answers}, class_name: Post.name, foreign_key: :marker_id

  validates :name, :email, presence: true

  scope :new_users, ->{where "users.created_at BETWEEN DATE_SUB(NOW(), INTERVAL 1 MONTH) AND NOW()"}
  scope :voter, (->(id) do
    joins(votes: [post: :course]).where(courses: {id: id}).group(:id)
      .select("users.*, COUNT(*) AS vote_count").order "vote_count DESC"
  end)
  scope :search_by_name, ->(user_name){where User.arel_table[:name].matches("%#{user_name}%")}
  scope :lecturers, ->{where lecturer: true}
  scope :students, ->{where lecturer: false}
  scope :of_courses, ->(courses){joins(:courses).where(courses: {id: courses.ids}).distinct}
  scope :group_by_user, (-> do
    select("users.id, users.name, users.avatar, COUNT(*) AS counter").group :id
  end)
  scope :course_posts, (->(post_type, course) do
    joins(:posts).merge(Post.send(post_type)).where posts: {course_id: course.id}
  end)
  scope :course_questions_answers, (->(course) do
    select("users.id, users.name, COUNT(NULLIF(1, posts.post_type)) AS questions_count, COUNT(NULLIF(0, posts.post_type)) AS answers_count")
      .left_outer_joins(:posts).where(posts: {course_id: course.id}).group :id
  end)
  scope :course_comments, ->(course){joins(:comments).where comments: {post_id: course.posts.ids}}
  scope :course_votes, ->(course){joins(:votes).where votes: {post_id: course.posts.ids}}
  scope :most_active, ->{order("counter DESC").limit Settings.course.length}
end

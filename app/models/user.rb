class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  validates :name, :email, presence: true

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, foreign_key: :owner_user_id, dependent: :destroy
  has_many :comments
  has_many :votes, dependent: :destroy
  has_many :voted_posts, through: :votes, source: :post
  has_many :answers, through: :posts, source: :answers
  has_many :user_courses, dependent: :destroy
  has_many :courses, through: :user_courses

  scope :new_users, ->{where "users.created_at BETWEEN DATE_SUB(NOW(), INTERVAL 1 MONTH) AND NOW()"}
  scope :voter, ->{joins(:votes).group(:id).select("users.*, COUNT(*) AS vote_count").order "vote_count DESC"}
  scope :search_by_name, ->(user_name){where User.arel_table[:name].matches("%#{user_name}%")}
  scope :lecturers, ->{where lecturer: true}
end

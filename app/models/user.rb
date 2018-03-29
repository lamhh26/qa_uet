class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  validates :name, :email, presence: true

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, foreign_key: :owner_user_id, dependent: :destroy
  has_many :comments
  has_many :votes, dependent: :destroy
  has_many :voted_posts, through: :votes, source: :post
  has_many :answers, through: :posts, source: :answers
end

class Course < ApplicationRecord
  belongs_to :course_category
  has_many :posts

  validates :name, presence: true
end

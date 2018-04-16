class CourseCategory < ApplicationRecord
  has_many :courses

  scope :newest, ->{order year_from: :desc, year_to: :asc}
end

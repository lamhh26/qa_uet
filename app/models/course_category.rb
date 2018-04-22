class CourseCategory < ApplicationRecord
  has_many :courses

  scope :newest, ->{order date_from: :desc, date_to: :asc}

  def title
    "#{name} (#{date_from.strftime("%m/%Y")} - #{date_to.strftime("%m/%Y")})"
  end
end

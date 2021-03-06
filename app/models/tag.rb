class Tag < ApplicationRecord
  before_save :name_downcase
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  validates :name, presence: true, uniqueness: true

  default_scope {includes :posts}

  scope :load_tags, (-> do
    left_outer_joins(:posts).where(posts: {post_type: :question}).group(:id).select "tags.*, COUNT(*) AS tag_count"
  end)

  scope :popular, ->{order "tag_count DESC"}
  scope :unanswered, ->{where posts: {answers_count: 0}}
  scope :sort_by_name, ->{order :name}
  scope :search_by_name, ->(tag_name){where Tag.arel_table[:name].matches("%#{tag_name}%")}
  scope :of_course, ->(course){where posts: {course_id: course.id}}
  scope :of_courses, ->(courses){where posts: {course_id: courses.ids}}

  private

  def name_downcase
    name.downcase!
  end
end

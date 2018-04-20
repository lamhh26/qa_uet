module CourseHelper
  def courses_grouped_options user_courses
    user_courses.includes(:course_category).group_by(&:course_category).map do |course_category, courses|
      [course_category.title, courses.pluck(:name, :id)]
    end.unshift [nil, [["All", :all]]]
  end
end

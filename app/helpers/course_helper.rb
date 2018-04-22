module CourseHelper
  def courses_grouped_options user_courses, user
    user_courses.includes(:course_category).group_by(&:course_category).map do |course_category, courses|
      [course_category.title, courses.pluck(:name, :id)]
    end.unshift [nil, [["#{current_user == user ? "All" : "All courses together"}", :all]]]
  end

  def chart_data course_presenter
    [["Student", course_presenter.course.users.students.size]] << ["Question", course_presenter.load_size_by_course(:question)] <<
      ["Answer", course_presenter.load_size_by_course(:answer)] << ["Comment", course_presenter.load_size_by_course(:comment)] <<
      ["Vote", course_presenter.load_size_by_course(:vote)]
  end
end

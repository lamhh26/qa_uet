class CoursePresenter
  attr_reader :course, :posts, :comments, :votes

  def initialize course
    @course = course
  end

  def user_most_active
    @course.users.group_by_user.most_active
  end

  def load_by_course object_type
    case object_type
    when :question
      Post.question.of_courses @course
    when :answer
      Post.answer.of_courses course
    when :comment
      Comment.of_courses @course.posts
    when :vote
      Vote.of_courses course.posts
    end
  end

  def load_size_by_course object_type
    load_by_course(object_type).size
  end

  def group_date object_type, group_type = :week
    course_category = course.course_category
    range = course_category.date_from..course_category.date_to
    return load_by_course(object_type).group_by_week(:created_at, range: range).size if group_type == :week
    load_by_course(object_type).group_by_month(:created_at, range: range).size
  end

  def load_user_details
    @posts = User.course_questions_answers @course
    @comments = User.course_comments(@course).group_by_user.size
    @votes = User.course_votes(@course).group_by_user.size
  end
end

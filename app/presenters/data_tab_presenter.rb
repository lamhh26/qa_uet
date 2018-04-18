class DataTabPresenter
  def initialize object, tab, sort = nil
    @object = object
    @tab = tab
    @sort = sort
  end

  def load_questions_home
    return @object.hot if @tab == "hot"
    return @object.this_week if @tab == "week"
    @object.this_month
  end

  def load_questions_index
    return @object.most_answers if @tab == "most_answers"
    return @object.newest if @tab == "newest"
    @object.votest
  end

  def load_unanswered_questions
    return @object.newest if @tab == "newest"
    @object.votest
  end

  def load_tags_index
    return @object.sort_by_name if @tab == "name"
    @object.popular
  end

  def load_users user, course
    return @object.new_users if @tab == "new_users"
    return @object unless @tab == "voter"
    return User.voter(course.id) if course
    User.voter user.courses.ids
  end

  def load_user_answers
    return @object.newest if @sort == "newest"
    @object.votest
  end

  def load_user_questions
    return @object.newest if @sort == "newest"
    return @object.viewest if @sort == "viewest"
    @object.votest
  end

  def load_user_tags
    return @object.votest if @sort == "votes"
    @object.sort_by_tag_name
  end

  def load_question_answers
    return @object.oldest if @tab == "oldest"
    @object.votest
  end

  def load_user_category_posts user
    return @object.answered_by_user(user).newest if @tab == "answered"
    @object.question.where.not(id: @object.answered_by_user(user)).newest
  end
end

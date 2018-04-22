class CoursesController < ApplicationController
  load_and_authorize_resource only: %i(show details)

  def index
    @courses = current_user.courses.newest.load_posts.includes :users, :course_category
  end

  def show
    @course_presenter = CoursePresenter.new @course
  end

  def details
    @course_presenter = CoursePresenter.new @course
    @course_presenter.load_user_details
  end
end

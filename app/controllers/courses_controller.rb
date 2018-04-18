class CoursesController < ApplicationController
  def index
    @courses = current_user.courses.newest.load_posts.includes :users, :course_category
  end
end

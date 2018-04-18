class StaticPagesController < ApplicationController
  before_action :load_course, :load_course_posts, :load_course_tags

  def hot
    questions_data = @course_posts.includes(:owner_user, :tags, :answers).question.load_votes.select_posts_votes
                                  .viewest.most_answers.votest
    @tab = tab_active "month", "hot", "week", "month"
    @questions = DataTabPresenter.new(questions_data, @tab).load_questions_home.page(params[:page])
                                 .per Settings.paginate.per_page
    @tags = @course_tags.popular.limit Settings.tag.popular_length
  end
end

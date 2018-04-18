class UnansweredsController < ApplicationController
  before_action :load_course, :load_course_posts, :load_course_tags

  def show
    unanswered_questions_data = @course_posts.includes(:owner_user, :tags, :answers).question.load_votes
                                             .select_posts_votes.unanswered
    @unanswered_tags = @course_tags.popular.unanswered
    @tab = tab_active "votest", "newest", "votest"
    @unanswered_questions = DataTabPresenter.new(unanswered_questions_data, @tab).load_unanswered_questions
                                            .page(params[:page]).per Settings.paginate.per_page
  end

  def tagged
    unanswered_questions_data = @course_posts.includes(:owner_user, :answers, :tags).question.load_votes.select_posts_votes
                                             .unanswered.load_tag_by_name params[:name]
    @unanswered_tags = @course_tags.popular.unanswered
    @tab = tab_active "votest", "newest", "votest"
    @unanswered_questions = DataTabPresenter.new(unanswered_questions_data, @tab).load_unanswered_questions
                                            .page(params[:page]).per Settings.paginate.per_page
  end
end

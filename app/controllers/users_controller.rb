class UsersController < ApplicationController
  before_action :check_user_session, only: %i(edit update)
  before_action :load_user, except: %i(index)
  before_action :check_current_user, only: %i(edit update)

  def index
    users_data = User.all
    @tab = tab_active "all", "voter", "new_users", "all"
    users_data = users_data.search_by_name params[:q] if params[:q].present? && request.xhr?
    @users = DataTabPresenter.new(users_data, @tab).load_users.page(params[:page])
                             .per Settings.paginate.tags.per_page
    respond_format_js if request.xhr?
  end

  def show
    @tab = tab_active "profile", "activity", "profile", "categories"

    if @tab == "activity"
      @answers = @user.posts.answer.load_votes.select_posts_votes.votest.includes(:question)
                      .page(params[:page]).per Settings.paginate.per_page
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    if @user.update_attributes user_params
      flash[:notice] = "Your profile successfully updated!"
      redirect_to user_path @user
    else
      render :edit
    end
  end

  def answers
    return unless request.xhr?
    answers = @user.posts.answer.load_votes.select_posts_votes.includes :question
    @sort = tab_sort_active "votest", "votest", "newest"
    @user_answers = DataTabPresenter.new(answers, nil, @sort).load_user_answers.page(params[:page])
                                    .per Settings.paginate.per_page
    respond_format_js
  end

  def questions
    return unless request.xhr?
    questions = @user.posts.question.load_votes.select_posts_votes.includes :tags
    @sort = tab_sort_active "votest", "votest", "newest", "viewest"
    @user_questions = DataTabPresenter.new(questions, nil, @sort).load_user_questions.page(params[:page])
                                      .per Settings.paginate.per_page
    respond_format_js
  end

  def tags
    return unless request.xhr?
    tags = @user.posts.left_outer_joins(:votes).select_votes.joins(:tags)
                .select("tags.name, count(*) as posts_count").group("tags.name")
    @sort = tab_sort_active "name", "votest", "name"
    @user_tags = DataTabPresenter.new(tags, nil, @sort).load_user_tags.page(params[:page])
                                 .per Settings.paginate.tags.per_page
    respond_format_js
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    check_object_exists @user, root_url
  end

  def user_params
    params[:user][:category_ids].reject!(&:blank?) if params[:user][:category_ids].present?
    params.require(:user).permit :name, :birth_day, :email, :about_me, :avatar, category_ids: []
  end

  def check_current_user
    redirect_to user_path(@user) unless current_user == @user
  end
end

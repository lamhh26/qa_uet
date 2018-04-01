class UsersController < ApplicationController
  before_action :check_user_session, except: %i(show index)
  before_action :load_user, except: %i(index)
  before_action :check_user, only: %i(edit update)

  def index
    @tab = tab_active "all", "voter", "new_users", "all"
    @users = DataTabPresenter.new(User.all, @tab).load_users.page(params[:page])
                             .per Settings.paginate.tags.per_page
  end

  def show
    @tab = tab_active "profile", "activity", "profile"
    @answers = @user.posts.answer.load_votes.select_posts_votes
  end

  def edit; end

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
    @answers = @user.posts.answer.load_votes.select_posts_votes
    @sort = tab_sort_active "votest", "votest", "newest"
    respond_format_js
  end

  def questions
    return unless request.xhr?
    @questions = @user.posts.question.load_votes.select_posts_votes
    @sort = tab_sort_active "votest", "votest", "newest", "viewest"
    respond_format_js
  end

  def tags
    return unless request.xhr?
    @tags = current_user.posts.left_outer_joins(:votes).select_votes.joins(:tags)
                        .select("tags.name as tag_name, count(*) as posts_count").group("tag_name")
    @sort = tab_sort_active "name", "votest", "name"
    respond_format_js
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    check_object_exists @user, root_url
  end

  def user_params
    params.require(:user).permit :name, :birth_day, :email, :about_me, :avatar
  end

  def check_user
    redirect_to user_path(@user) unless current_user == @user
  end
end

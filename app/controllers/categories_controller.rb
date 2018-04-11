class CategoriesController < ApplicationController
  before_action :load_user
  before_action :check_consultant
  before_action :load_category

  def show
    @tab = tab_active "answered", "unanswered", "answered"
    @category_posts = DataTabPresenter.new(@category.posts, @tab).load_category_posts(@user)
                                      .load_votes.select_posts_votes.includes(:votes, :tags).page(params[:page])
                                      .per Settings.paginate.tags.per_page
  end

  private

  def load_user
    @user = User.find_by id: params[:user_id]
    check_object_exists @user, root_url
  end

  def check_consultant
    redirect_to user_path(@user) unless @user.consultant?
  end

  def load_category
    @category = Category.find_by id: params[:id]
    redirect_to user_path(@user) unless @user.categories.exists? id: params[:id]
  end
end

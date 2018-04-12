class CategoriesController < ApplicationController
  before_action :load_category

  def show
    @tab = tab_active "active", "active", "votest", "most_answers", "viewest"
    @category_posts = DataTabPresenter.new(load_category_posts, @tab).load_category_posts
                                      .includes(:owner_user, :tags, :answers).page(params[:page])
                                      .per Settings.paginate.per_page
    @name = @category ? @category.name : :uncategory
    if @tab == "active"
      @active_category_posts = load_category_posts.load_votes.select_id_votes.group_by &:id
    end
  end

  private

  def load_category
    return if params[:name] == "uncategory"
    @category = Category.find_by name: params[:name]
    redirect_to category_path(name: :uncategory) unless @category
  end

  def load_category_posts
    return Post.question.where(category: nil) if params[:name] == "uncategory"
    @category.posts.question
  end
end

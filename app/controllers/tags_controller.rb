class TagsController < ApplicationController
  def show
    tags_data = Tag.load_tags
    tags_data = tags_data.search_by_name params[:q] if params[:q].present? && request.xhr?
    @tab = tab_active "popular", "name", "popular"
    @tags = DataTabPresenter.new(tags_data, @tab).load_tags_index.page(params[:page])
                            .per Settings.paginate.tags.per_page
    respond_format_js if request.xhr?
  end

  def search
    return unless request.xhr?
    tags = search_by_name
    render json: tags
  end

  private

  def search_by_name
    return [] if params[:name].blank?
    Tag.where.not(name: except_names).search_by_name(params[:name].strip).pluck :name
  end

  def except_names
    return [] if params[:except_names].blank?
    params[:except_names].split(",").map!(&:strip)
  end
end

class TagsController < ApplicationController
  def show
    @tags = Tag.load_tags
  end
end

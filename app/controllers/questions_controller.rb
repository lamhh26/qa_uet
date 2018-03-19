class QuestionsController < ApplicationController
  def index
    @questions = Post.includes(:owner_user, :tags, :answers).question.load_vote
  end

  def show
  end
end

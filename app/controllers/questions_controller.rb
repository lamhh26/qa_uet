class QuestionsController < ApplicationController
  impressionist actions: [:show], unique: [:session_hash]
  before_action :load_question, only: :show

  def index
    @questions = Post.includes(:owner_user, :tags, :answers).question.load_votes
  end

  def show; end

  def tagged
    @tagged_questions = Post.includes(:owner_user, :answers).question.load_votes.load_tag_by_name params[:name]
  end

  private

  def load_question
    @question = Post.question.load_votes.find_by id: params[:id]
    redirect_to questions_url unless @question
  end
end

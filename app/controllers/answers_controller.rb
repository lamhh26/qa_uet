class AnswersController < ApplicationController
  before_action :check_user_session
  before_action :load_question_without_owner, except: %i(upvote downvote)
  before_action :load_question, only: %i(upvote downvote)
  before_action :load_answer, except: %i(create)

  def create
    return unless request.xhr?
    @answer = @question.answers.build answer_params.merge! post_type: :answer, owner_user_id: current_user.id
    @result = @answer.save
  end

  def edit
    return unless request.xhr?
    respond_to do |format|
      format.html{redirect_to question_path(@question)}
      format.js
    end
  end

  def update
    return unless request.xhr?
    @result = @answer.update_attributes answer_params
  end

  def destroy
    if @answer.destroy
      flash[:notice] = "Deleted successful answer"
    else
      flash[:danger] = "Deleted failed answer"
    end
    redirect_to question_url(@question)
  end

  def upvote
    return unless request.xhr?
    @vote = @answer.vote_by current_user
    if @vote.persisted? && @vote.down_mod?
      @result = @vote.destroy
    else
      @vote.vote_type = :up_mod
      @result = @vote.save
    end
    respond_format_js
  end

  def downvote
    return unless request.xhr?
    @vote = @answer.vote_by current_user
    if @vote.persisted? && @vote.up_mod?
      @result = @vote.destroy
    else
      @vote.vote_type = :down_mod
      @result = @vote.save
    end
    respond_format_js
  end

  private

  def load_question
    @question = Post.question.find_by id: params[:question_id]
    check_object_exists @question, questions_url
  end

  def load_question_without_owner
    @question = Post.question.where.not(owner_user: current_user).find_by id: params[:question_id]
    check_object_exists @question, questions_url
  end

  def load_answer
    @answer = @question.answers.load_votes.select_posts_votes.find_by id: params[:id]
    check_object_exists @question, questions_url
  end

  def answer_params
    params.require(:answer).permit :body
  end
end

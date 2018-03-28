class QuestionCommentsController < ApplicationController
  before_action :check_user_session
  before_action :load_question
  before_action :load_comment, only: %i(edit update destroy)

  def create
    @comment = @question.comments.build comment_params.merge!(user_id: current_user.id)
    @result = @comment.save
    respond_format_js
  end

  def edit
    respond_format_js
  end

  def update
    @result = @comment.update_attributes comment_params
    respond_format_js
  end

  def destroy
    @result = @comment.destroy
    respond_format_js
  end

  private

  def load_question
    @question = Post.question.find_by id: params[:question_id]
    redirect_to questions_url unless @question
  end

  def load_comment
    @comment = @question.comments.find_by id: params[:id], user: current_user
    redirect_to question_url(@question) unless @comment
  end

  def comment_params
    params.require(:comment).permit :text
  end

  def respond_format_js
    respond_to do |format|
      format.js
    end
  end
end

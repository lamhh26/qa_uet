class AnswerCommentsController < ApplicationController
  before_action :check_user_session
  before_action :load_answer
  before_action :load_comment, only: %i(edit update destroy)

  def create
    @comment = @answer.comments.build comment_params.merge!(user_id: current_user.id)
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

  def load_answer
    @answer = Post.answer.find_by id: params[:answer_id]
    ajax_redirect_to questions_url unless @answer
  end

  def load_comment
    @comment = @answer.comments.find_by id: params[:id], user: current_user
    ajax_redirect_to question_url(@answer) unless @comment
  end

  def comment_params
    params.require(:comment).permit :text
  end
end

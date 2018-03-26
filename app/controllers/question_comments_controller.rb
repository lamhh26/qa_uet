class QuestionCommentsController < ApplicationController
  before_action :authenticate_user!, only: %i(new create)
  before_action :load_question
  before_action :load_comment, only: %i(edit update destroy)

  def create
    @comment = @question.comments.build comment_params.merge!(user_id: current_user.id)
    @result = @comment.save
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    @result = @comment.update_attributes comment_params
    respond_to do |format|
      format.js
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.js
      end
    else
      redirect_to question_path(@question)
    end
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
end

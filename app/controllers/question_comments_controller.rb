class QuestionCommentsController < ApplicationController
  before_action :load_question
  before_action :load_comment, only: %i(edit update destroy)

  def create
    return unless request.xhr?
    @comment = @post.comments.build comment_params.merge!(user_id: current_user.id)
    @result = @comment.save
    respond_format_js
  end

  def edit
    return unless request.xhr?
    respond_format_js
  end

  def update
    return unless request.xhr?
    @result = @comment.update_attributes comment_params
    respond_format_js
  end

  def destroy
    return unless request.xhr?
    @result = @comment.destroy
    respond_format_js
  end

  private

  def load_question
    @post = Post.question.find_by id: params[:question_id]
    authorize! :read, @post
  end

  def load_comment
    @comment = @post.comments.find_by id: params[:id], user: current_user
    authorize! action_name.to_sym, @comment
  end

  def comment_params
    params.require(:comment).permit :text
  end
end

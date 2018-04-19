class AnswerCommentsController < ApplicationController
  before_action :load_answer
  before_action :load_comment, except: :create

  def create
    @comment = @post.comments.build comment_params.merge!(user_id: current_user.id)
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
    @post = Post.answer.find_by id: params[:answer_id]
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

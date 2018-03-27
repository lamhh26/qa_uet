class AnswersController < ApplicationController
  before_action :load_question
  before_action :load_answer, except: %i(create)

  def create
    @answer = @question.answers.build answer_params.merge! post_type: :answer, owner_user_id: current_user.id
    @result = @answer.save
  end

  def edit
    respond_to do |format|
      format.html{redirect_to question_path(@question)}
      format.js
    end
  end

  def update
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

  private

  def load_question
    @question = Post.question.where.not(owner_user: current_user).find_by id: params[:question_id]
    redirect_to questions_url unless @question
  end

  def load_answer
    @answer = @question.answers.find_by id: params[:id]
    redirect_to question_url(@question) unless @question
  end

  def answer_params
    params.require(:answer).permit :body
  end
end

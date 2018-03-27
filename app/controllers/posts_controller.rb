class PostsController < ApplicationController
  impressionist actions: [:show], unique: [:session_hash]
  before_action :authenticate_user!, except: %i(index show tagged)
  before_action :load_question_with_vote, only: :show
  before_action :load_question_with_owner_user, only: %i(edit update destroy)

  def index
    @questions = Post.includes(:owner_user, :tags, :answers).question.load_votes
  end

  def show; end

  def new
    @question = current_user.posts.build post_type: :question
  end

  def create
    @question = current_user.posts.build question_params
    if @question.save
      flash[:notice] = "Question was successfully created!"
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @question.update_attributes question_params
      flash[:notice] = "Question was successfully created!"
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def destroy
    if @question.destroy
      flash[:notice] = "Deleted successful question"
    else
      flash[:danger] = "Deleted failed question"
    end
    redirect_to questions_url
  end

  def tagged
    @tagged_questions = Post.includes(:owner_user, :answers).question.load_votes.load_tag_by_name params[:name]
  end

  private

  def load_question_with_vote
    @question = Post.question.load_votes.find_by id: params[:id]
    redirect_to questions_url unless @question
  end

  def load_question_with_owner_user
    @question = current_user.posts.question.find_by id: params[:id]
    redirect_to questions_url unless @question
  end

  def question_params
    params.require(:post).permit :title, :body, :all_tags
  end
end

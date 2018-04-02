class PostsController < ApplicationController
  impressionist actions: [:show], unique: [:session_hash]
  before_action :authenticate_user!, except: %i(index show tagged upvote downvote)
  before_action :check_user_session, only: %i(upvote downvote)
  before_action :load_question_with_vote, only: %i(show upvote downvote)
  before_action :load_question_with_owner_user, only: %i(edit update destroy)

  def index
    questions_data = Post.includes(:owner_user, :tags, :answers).question.load_votes.select_posts_votes
    @tags = Tag.load_tags.popular.limit Settings.tag.popular_length
    @tab = tab_active "votest", "most_answers", "newest", "votest"
    @questions = DataTabPresenter.new(questions_data, @tab).load_questions_index.page(params[:page])
                                 .per Settings.paginate.per_page
  end

  def show
    @related_questions = Post.question.related_questions(@question).limit Settings.question.related_questions_length
  end

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
    tagged_questions_data = Post.includes(:owner_user, :answers).question.load_votes.select_posts_votes
                            .load_tag_by_name params[:name]
    @tags = Tag.load_tags.popular.limit Settings.tag.popular_length
    @tab = tab_active "votest", "most_answers", "newest", "votest"
    @tagged_questions = DataTabPresenter.new(tagged_questions_data, @tab).load_questions_index.page(params[:page])
                                        .per Settings.paginate.per_page
  end

  def upvote
    return unless request.xhr?
    @vote = @question.vote_by current_user
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
    @vote = @question.vote_by current_user
    if @vote.persisted? && @vote.up_mod?
      @result = @vote.destroy
    else
      @vote.vote_type = :down_mod
      @result = @vote.save
    end
    respond_format_js
  end

  private

  def load_question_with_vote
    @question = Post.question.load_votes.select_posts_votes.find_by id: params[:id]
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

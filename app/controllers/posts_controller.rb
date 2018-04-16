class PostsController < ApplicationController
  impressionist actions: [:show], unique: [:session_hash]
  before_action :load_question_with_vote, only: %i(show upvote downvote)
  before_action :load_courses, only: %i(new create edit update)
  load_and_authorize_resource through: :current_user, except: %i(index show upvote downvote tagged)

  def index
    questions_data = Post.includes(:owner_user, :tags, :answers).question.load_votes.select_posts_votes
    @tags = Tag.load_tags.popular.limit Settings.tag.popular_length
    @tab = tab_active "votest", "most_answers", "newest", "votest"
    @questions = DataTabPresenter.new(questions_data, @tab).load_questions_index.page(params[:page])
                                 .per Settings.paginate.per_page
  end

  def show
    @related_questions = Post.question.related_questions(@post).limit Settings.question.related_questions_length
    answers_data = @post.answers.load_votes.select_posts_votes.includes [comments: :user], :owner_user,
      :votes, :question
    @tab = tab_active "votest", "oldest", "votest"
    @answers = DataTabPresenter.new(answers_data, @tab).load_question_answers.page(params[:page])
                               .per Settings.paginate.question_answers.per_page
    @new_answer = @post.answers.build owner_user: current_user, post_type: 1
  end

  def new
    @post = current_user.posts.build post_type: :question
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      flash[:notice] = "Question was successfully created!"
      redirect_to question_path(@post)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update_attributes post_params
      flash[:notice] = "Question was successfully created!"
      redirect_to question_path(@post)
    else
      render :new
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "Deleted successful question"
    else
      flash[:danger] = "Deleted failed question"
    end
    redirect_to questions_url
  end

  def tagged
    tagged_questions_data = Post.includes(:owner_user, :answers, :tags).question.load_votes.select_posts_votes
                                .load_tag_by_name params[:name]
    @tags = Tag.load_tags.popular.limit Settings.tag.popular_length
    @tab = tab_active "votest", "most_answers", "newest", "votest"
    @tagged_questions = DataTabPresenter.new(tagged_questions_data, @tab).load_questions_index.page(params[:page])
                                        .per Settings.paginate.per_page
  end

  def upvote
    return unless request.xhr?
    @vote = @post.vote_by current_user
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
    @vote = @post.vote_by current_user
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
    @post = Post.question.load_votes.select_posts_votes.find_by id: params[:id]
    authorize! action_name.to_sym, @post
  end

  def post_params
    params.require(:post).permit :title, :body, :all_tags, :course_id
  end

  def load_courses
    @courses = Course.pluck(:name, :id).map{|v| [v[0].humanize, v[1]]}
  end
end

class UnansweredsController < ApplicationController
  def show
    @unanswered_questions = Post.includes(:owner_user, :tags, :answers).question.load_votes
                                .select_posts_votes.unanswered
  end

  def tagged
    @unanswered_questions = Post.includes(:owner_user, :answers).question.load_votes.select_posts_votes
                                .unanswered.load_tag_by_name params[:name]
  end
end

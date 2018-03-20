class StaticPagesController < ApplicationController
  def home
    @questions = Post.includes(:owner_user, :tags, :answers).question.load_vote.votes.most_answers
  end
end

class StaticPagesController < ApplicationController
  def home
    @questions = Post.includes(:owner_user, :tags, :answers).question.load_votes.votes.most_answers
  end
end

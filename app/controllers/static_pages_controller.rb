class StaticPagesController < ApplicationController
  def home
    @questions = Post.includes(:owner_user, :tags, :answers).question.load_votes.viewest
                     .most_answers.votes
  end
end

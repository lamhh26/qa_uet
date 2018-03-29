class StaticPagesController < ApplicationController
  def home
    @questions = Post.includes(:owner_user, :tags, :answers).question.load_votes.select_posts_votes
                     .viewest.most_answers.votest
    @tags = Tag.load_tags.limit Settings.tag.popular_length
  end
end

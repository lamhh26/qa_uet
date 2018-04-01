module VotingHelper
  def voting_class post, vote_type
    return unless current_user
    vote = post.vote_by current_user
    return "voting-color" if vote.vote_type == vote_type
  end

  def voting_path post, vote_type
    if post.question?
      return upvote_question_path(post) if vote_type == :up_mod
      downvote_question_path post
    else
      return upvote_question_answer_path(post.question, post) if vote_type == :up_mod
      downvote_question_answer_path post.question, post
    end
  end
end

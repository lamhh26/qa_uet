module VotingHelper
  def voting_class post, vote_type_value
    return unless current_user
    user_vote_value = post.vote_value_by current_user
    return if user_vote_value == 0
    return "voting-color" if user_vote_value == vote_type_value
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

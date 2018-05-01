class Ability
  include CanCan::Ability

  def initialize user
    return if user.blank?
    alias_action :answers, :questions, :tags, :tagged, to: :read
    can :create_question, Course, id: user.courses.ids
    can :read, User, courses: {id: user.courses.ids}
    can :update, User, id: user.id
    can :read, Post, course: {id: user.courses.ids}
    cannot :show, Post, post_type: :answer
    can %i(upvote downvote), Post
    can %i(create update destroy), Post, Post do |post|
      post.question? ? (post.owner_user_id == user.id) : (post.question.owner_user_id != user.id)
    end
    can :create, [Vote, Comment], post: {course_id: user.courses.ids}
    can %i(update destroy), [Vote, Comment], user_id: user.id
    return unless user.lecturer?
    can %i(mark_best_answer unmark_best_answer), Post
    can %i(show details), Course, id: user.courses.ids
  end
end

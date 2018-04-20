module AnswerHelper
  def check_icon_best_answer answer
    return unless current_user.lecturer? || answer.best_answer?
    if current_user.lecturer?
      url = if answer.best_answer?
              unmark_best_answer_question_answer_path(answer.question, answer)
            else
              mark_best_answer_question_answer_path(answer.question, answer)
            end
      link_to url, data: {remote: true, method: :patch} do
        content_tag :div, class: "qa-a-selection check-icon-toggle #{answer.best_answer? ? 'open' : nil}",
          title: answer.best_answer_title do
          render partial: "shared/check_icon"
        end
      end
    else
      content_tag :div, class: "qa-a-selection check-icon-toggle open", title: answer.best_answer_title do
        render partial: "shared/check_icon"
      end
    end
  end
end

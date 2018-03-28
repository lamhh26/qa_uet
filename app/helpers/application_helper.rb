module ApplicationHelper
  def flash_class level
    case level
    when "notice", "success" then "alert-success"
    when "error" then "alert-error"
    when "alert", "danger" then "alert-danger"
    when "warning" then "alert-warning"
    end
  end

  def owner_user? user
    current_user == user if current_user && user
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_user_session
  before_action :load_notifications

  rescue_from ActiveRecord::RecordNotFound do |_|
    flash[:danger] = "Not found!"
    redirect_to root_url
  end

  rescue_from CanCan::AccessDenied do |exception|
    request.xhr? ? ajax_redirect_to(nil, exception.message) : redirect_to(root_url, alert: exception.message)
  end

  def page_404
    render file: "public/404.html", status: :not_found
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: %i(name email)
    devise_parameter_sanitizer.permit :sign_in, keys: [:email]
  end

  def check_user_session
    return if user_signed_in?
    request.xhr? ? ajax_redirect_to(nil, I18n.t("devise.failure.unauthenticated")) : authenticate_user!
  end

  def check_object_exists object, url
    return if object
    request.xhr? ? ajax_redirect_to(url) : redirect_to(url)
  end

  def respond_format_js
    respond_to do |format|
      format.js
    end
  end

  def tab_active default_tab, *tabs
    tabs.include?(params[:tab]) ? params[:tab] : default_tab
  end

  def tab_sort_active default_tab, *tabs
    tabs.include?(params[:sort]) ? params[:sort] : default_tab
  end

  def load_course
    @course = current_user.courses.load_posts.find_by id: params[:course_id]
  end

  def load_course_posts
    @course_posts = @course ? @course.posts : Post.of_courses(current_user.courses)
  end

  def load_course_tags
    @course_tags = @course ? Tag.load_tags.of_course(@course) : Tag.load_tags.of_courses(current_user.courses)
  end

  private

  def ajax_redirect_to url = nil, message = nil
    head 302, x_ajax_redirect_url: url, x_ajax_message: message
  end

  def load_notifications
    return unless user_signed_in?
    @notifications = Notification.where(target: current_user).includes(:notifiable).newest
    @unread_noti_counter = @notifications.unopened_only.size
  end
end

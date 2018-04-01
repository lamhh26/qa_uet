class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def page_404
    render file: "public/404.html", status: :not_found
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: %i(name email)
    devise_parameter_sanitizer.permit :sign_in, keys: [:email]
  end

  def check_user_session
    return if current_user
    request.xhr? ? ajax_redirect_to(nil, I18n.t('devise.failure.unauthenticated')) : authenticate_user!
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

  private

  def ajax_redirect_to url = nil, message = nil
    head 302, x_ajax_redirect_url: url, x_ajax_message: message
  end
end

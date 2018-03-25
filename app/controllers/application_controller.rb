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
end

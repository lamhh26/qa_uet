class NotificationsController < ApplicationController
  before_action :load_notification, only: :open

  def index
    @notifications_pagination = @notifications.page(params[:page]).per Settings.paginate.per_page
  end

  def open
    return unless request.xhr?
    @notification.open!
    respond_format_js
  end

  def open_all
    return unless request.xhr?
    @notifications.update_all opened_at: Time.current
    respond_format_js
  end

  def self.controller_path
    "activity_notification/notifications/users"
  end

  private

  def load_notification
    @notification = @notifications.find_by id: params[:id]
    authorize! :open, @notification
  end
end

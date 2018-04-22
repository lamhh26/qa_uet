class Notification < ActivityNotification::Notification
  after_create_commit :run_notification

  def view_path
    path = key.split(".").join "/"
    "activity_notification/notifications/#{target_type.underscore.pluralize}/#{path}"
  end

  scope :newest, ->{order created_at: :desc}

  private

  def run_notification
    NotificationWorker.perform_async id, self.class.unopened_only.size
  end
end

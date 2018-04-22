class NotificationWorker
  include Sidekiq::Worker

  def perform id, counter
    notification = Notification.find_by id: id
    html = ApplicationController.render partial: notification.view_path, locals: {notification: notification}, formats: [:html]
    ActionCable.server.broadcast "notifications:#{notification.target_id}", html: html, counter: counter
  end
end

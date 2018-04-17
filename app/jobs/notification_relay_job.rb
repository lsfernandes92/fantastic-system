class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
    ActionCable.server.broadcast "notifications:#{notification.recipient_id}",
      html: render_message(notification)
  end

  private

    def render_message(notification)
      ApplicationController.render partial: "notifications/#{notification.notifiable_type.underscore.pluralize}/updated",
       locals: {notification: notification}, formats: [:html]
    end
end

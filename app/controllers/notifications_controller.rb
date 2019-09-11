class NotificationsController < Notifications::ApplicationController

  layout 'root/index'

  def index
    @pagy, @notifications = pagy(notifications.order('id desc'), items: 15)

    unread_ids = @notifications.reject(&:read?).select(&:id)
    Notification.read!(unread_ids)

    @notification_groups = @notifications.group_by { |note| note.created_at.to_date }
  end

  def clean
    notifications.delete_all
    redirect_to notifications_path
  end

  private

  def notifications
    raise 'You need reqiure user login for /notifications page.' unless current_user
    Notification.where(user_id: current_user.id)
  end
end
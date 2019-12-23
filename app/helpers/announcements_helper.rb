module AnnouncementsHelper
  def unread_notifications(user)
    'unread-notifications text-white' if user.notifications.unread.present?
  end
end

module AnnouncementsHelper

  def unread_notifications(user)
    if user.notifications.unread.present?
      "unread-notifications text-white"
    end
  end

end

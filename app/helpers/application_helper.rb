module ApplicationHelper

  include Pagy::Frontend

  def notice_class_for(flash_type)
    {
      success: "bg-teal-400 border-teal-300 text-teal-800",
      error: "bg-orange-400 border-orange-300 text-orange-800",
      alert: "bg-red-400 border-red-300 text-red-800",
      notice: "bg-green-400 border-green-300 text-green-800"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def disable_helper(text)
    icon('fas', 'spinner fa-pulse', text)
  end

  def notification_target_helper(notification)
    if notification.type == nil
      false
    else
      notification.user.slug
    end
  end

  def data_turbolinks_permanent_helper(pagy)
    unless pagy.last == pagy.page
      "data-turbolinks-permanent"
    end
  end

  def footer_class_link_helper
    "inline-block text-gray-500 hover:text-gray-400 pr-2"
  end

end

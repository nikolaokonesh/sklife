module ApplicationHelper

  def notice_class_for(flash_type)
    {
      success: "bg-teal-400 border-teal-300 text-teal-800",
      error: "bg-orange-400 border-orange-300 text-orange-800",
      alert: "bg-red-400 border-red-300 text-red-800",
      notice: "bg-green-400 border-green-300 text-green-800"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def user_avatar(user, size=40)
    if user.profile.avatar.attached?
      main_app.url_for(user.profile.avatar.variant(resize_to_fill: [ size, size ]))
    else
      gravatar_image_url(user.email, size: size)
    end
  end

  def user_avatar_helper(user, size=40, padding="9px 19px")
    content_tag(:span, '',
      style: "padding: #{padding}; background: url('#{user_avatar(user, size)}') no-repeat center;",
      class: 'shadow-md rounded-full mr-1')
  end

  def user_fon_helper(user, size=40, padding="9px 19px")
    if user.profile.fon.attached?
      content_tag(:span, '',
        style: "padding: #{padding}; background: url('#{main_app.url_for(user.profile.fon.variant(resize_to_fill: [ size, size ]))}') no-repeat center;",
        class: 'm-r-1')
    end
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

end

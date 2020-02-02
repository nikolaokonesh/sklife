module AvatarHelper
  def user_avatar(user, size = 40)
    if user.profile.avatar.attached?
      url_for(user.profile.avatar.variant(resize_to_fill: [size, size], extent: "#{size}x#{size}", gravity: 'Center', quality: 80))
    else
      gravatar_image_url(user.email, size: size)
    end
  end

  def user_avatar_helper(user, size = 40)
    content_tag(:span, '',
                style: "background: url('#{user_avatar(user, size)}') no-repeat center;",
                class: 'h-10 w-10 flex shadow-lg rounded-full mr-1')
  end

  def user_fon_helper(user, size = 40)
    return '' unless user.profile.fon.attached?

    html = <<-HTML
    <span class="h-10 w-10 flex cursor-pointer shadow-lg mr-1"
    style="background: url('#{url_for(user.profile.fon.variant(resize_to_fill: [size, size], quality: 50))}')
      no-repeat center;">
    </span>
    HTML

    html.html_safe
  end
end

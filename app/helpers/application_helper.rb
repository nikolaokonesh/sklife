module ApplicationHelper
  def notice_class_for(flash_type)
    {
      success: 'bg-teal-400 border-teal-300 text-teal-800',
      error: 'bg-orange-400 border-orange-300 text-orange-800',
      alert: 'bg-red-400 border-red-300 text-red-800',
      notice: 'bg-green-400 border-green-300 text-green-800'
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def disable_helper(texting)
    texting
  end

  def notification_target_helper(notification)
    if notification.type.nil?
      false
    else
      notification.user.slug
    end
  end

  def pag_helper(posts, texting, page = :page)
    link_to_next_page(posts, icon_svg('chevron-thin-down.svg', class: 'svg-default') + texting,
                      class: 'pg-link',
                      param_name: page, remote: true,
                      data: { disable_with: 'Загрузка...' })
  end

  def footer_class_link_helper
    'inline-block text-gray-500 hover:text-gray-400 pr-2'
  end
end

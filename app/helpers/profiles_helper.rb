module ProfilesHelper
  def background_helper(user_agent)
    if user_agent.present? && user_agent.profile.fon.attached?
      user_fon_attached(user_agent)
    elsif fonadmin.present? && fonadmin.profile.fon.attached?
      admin_fon_attached
    else
      gradi = content_tag :div, nil, style: "background: radial-gradient(at top, #00036566, #000727);", class: 'absolute w-full max-w-5xl h-64'
      imagi = image_tag('sputnik.png', class: 'w-full h-64 object-fit', data: { behavior: "uppy-preview" })
      return fon = gradi + imagi
    end
  end

  private

  def fonadmin
    User.where(admin: true).first
  end

  def user_fon_attached(user_agent)
    gradi = content_tag(:div, nil, style: "background: radial-gradient(at bottom, #{user_agent.profile.bgcolor}4f, #0b0b0be0);
                                  border-top: 8px solid #{user_agent.profile.bgcolor}50;", class: 'absolute w-full max-w-5xl h-64')
    imagi = image_tag(user_agent.profile.fon.variant(resize_to_fill: [1000, 500], blur: '0x3', quality: 70),
                                           data: { behavior: "uppy-preview" },
                                           class: 'w-full h-64 object-fit')
    return fon = gradi + imagi
  end

  def admin_fon_attached
    gradi = content_tag(:div, nil, style: "background: radial-gradient(at bottom, #{fonadmin.profile.bgcolor}4f, #0b0b0be0);
                                  border-top: 8px solid #{fonadmin.profile.bgcolor}50;", class: 'absolute w-full max-w-5xl h-64')
    imagi = image_tag(fonadmin.profile.fon.variant(resize_to_fit: [800, 800], blur: '0x3', quality: 50),
                                           data: { behavior: "uppy-preview" },
                                           class: 'w-full h-64 object-fit')
    return fon = gradi + imagi
  end
end

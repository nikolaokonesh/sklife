module ProfilesHelper
  def background_helper(user_agent)
    if user_agent.present? && user_agent.profile.fon.attached?
      user_fon_attached(user_agent)
    elsif fonadmin.present? && fonadmin.profile.fon.attached?
      admin_fon_attached
    else
      "background: radial-gradient(at top, #00036566, #000727),
                   url('#{image_path('sputnik.png')}') no-repeat center top;"
    end
  end

  private

  def fonadmin
    User.where(admin: true).first
  end

  def user_fon_attached(user_agent)
    "background: radial-gradient(at top, #{user_agent.profile.bgcolor}4f, #0b0b0be0),
      url('#{main_app.url_for(user_agent.profile.fon.variant(resize_to_fit: [800, 800], blur: '0x3', quality: 50))}')
      no-repeat center / cover;
      border-top: 8px solid #{user_agent.profile.bgcolor}50;"
  end

  def admin_fon_attached
    "background: radial-gradient(at bottom, #{fonadmin.profile.bgcolor}4f, #0b0b0be0),
      url('#{main_app.url_for(fonadmin.profile.fon.variant(resize_to_fit: [800, 800], blur: '0x3', quality: 50))}')
      no-repeat center / cover;
      border-top: 8px solid #{fonadmin.profile.bgcolor}50;"
  end
end

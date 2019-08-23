module ProfilesHelper

  def background_helper(user_agent)
    if user_agent.present? && user_agent.profile.fon.attached?
      "
        background:
          radial-gradient(at top, #{user_agent.profile.bgcolor}75, #000000c3), url('#{ main_app.url_for(user_agent.profile.fon.variant(resize_to_fill: [ 1100, 800 ])) }') no-repeat center / cover;
        border-top:
          8px solid #{user_agent.profile.bgcolor}50;
        border-bottom:
          8px solid #{user_agent.profile.bgcolor}50;
      "
    elsif fonadmin.present? && fonadmin.profile.fon.attached?
      "
        background:
          radial-gradient(at top, #{fonadmin.profile.bgcolor}75, #000000c3), url('#{main_app.url_for(fonadmin.profile.fon.variant(resize_to_fill: [ 1100, 800 ]))}') no-repeat center / cover;
        border-top:
          8px solid #{fonadmin.profile.bgcolor}50;
        border-bottom:
          8px solid #{fonadmin.profile.bgcolor}50;
      "
    else
      "background: radial-gradient(at top, #00036566, #000727), url('#{image_path('sputnik.png')}') no-repeat center top;"
    end
  end

  private

    def fonadmin
      User.where(admin: true).first
    end

end

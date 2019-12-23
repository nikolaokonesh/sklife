class ProfilesController < ApplicationController
  before_action :authenticate_user!
  layout 'blog/index'

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      imaginear_flow
      imaginear_flow_present
      flash[:notice] = 'Профиль успешно обновлен!'
    else
      render partial: 'error', profile: @profile, status: :bad_request
    end
  end

  private

  def attach_param
    params[:profile][:avatar]
  end

  def fon_attach_param
    params[:profile][:fon]
  end

  def imaginear_flow
    @profile.fon.purge_later if params[:profile][:fon_purge] == '1'
    @profile.avatar.purge_later if params[:profile][:avatar_purge] == '1'
  end

  def imaginear_flow_present
    @profile.avatar.attach(attach_param) if attach_param.present?
    @profile.fon.attach(fon_attach_param) if fon_attach_param.present?
  end

  def profile_params
    params.require(:profile).permit(:org, :bio, :email, :phone, :avatar, :fon, :bgcolor)
  end
end

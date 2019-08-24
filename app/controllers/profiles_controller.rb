class ProfilesController < ApplicationController
  before_action :authenticate_user!
  layout 'blog/index'

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      @profile.fon.purge_later if params[:profile][:fon_purge] == "1"
      @profile.avatar.purge_later if params[:profile][:avatar_purge] == "1"
      @profile.avatar.attach(attach_param) if attach_param.present?
      @profile.fon.attach(fon_attach_param) if fon_attach_param.present?
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

    def profile_params
      params.require(:profile).permit(:bio, :prof, :org, :email, :phone, :avatar, :fon, :bgcolor)
    end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user_subscribed?
  helper_method :summ_short_month
  helper_method :summ_long_month
  before_action :user_show
  before_action :sbrf_action

  include RescueFormConcern

  protected

  def current_user_subscribed?
    user_signed_in? && current_user.subscribed?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[slug subscribe_at name])
  end

  def sbrf_action
    # if Rails.env.production?
    #   @sbrf_client ||= SBRF::Acquiring::Client.new(username: Rails.application.credentials.dig(:sbrf, :username),
    # password: Rails.application.credentials.dig(:sbrf, :password))
    # else
    @sbrf_client = SBRF::Acquiring::Client.new(token: Rails.application.credentials.dig(:sbrf, :token_test),
                                               test: true)
    # end
  end

  def user_show
    @user_agent = User.where(slug: request.subdomain).first if request.subdomain.present?
  end

  def summ_short_month
    '220'
  end

  def summ_long_month
    '1450'
  end
end

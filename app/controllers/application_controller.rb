class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pagy::Backend
  include RescueFormConcern
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user_subscribed?
  helper_method :summ_small_month
  helper_method :summ_large_month
  helper_method :summ_largest_month
  before_action :user_show
  before_action :sbrf_action

  # before_action :searchs

  protected

    def current_user_subscribed?
      user_signed_in? && current_user.subscribed?
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:slug, :subscribe_at, :name])
    end

    def sbrf_action
      # if Rails.env.production?
      #   @sbrf_client ||= SBRF::Acquiring::Client.new(username: Rails.application.credentials.dig(:sbrf, :username), password: Rails.application.credentials.dig(:sbrf, :password))
      # else
        @sbrf_client ||= SBRF::Acquiring::Client.new(token: Rails.application.credentials.dig(:sbrf, :token_test), test: true)
      # end
    end

    # def searchs
    #   @q = Article::Post.ransack(params[:q])
    # end

    def user_show
      @user_agent = User.where(:slug => request.subdomain).first
    end

    def summ_small_month
      "340"
    end
    def summ_large_month
      "620"
    end
    def summ_largest_month
      "1290"
    end

end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Pagy::Backend

  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user_subscribed?
  helper_method :summ_small_month
  helper_method :summ_large_month
  before_action :user_show
  before_action :sbrf_action

  # before_action :searchs

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, alert: 'Вы не авторизованы для просмотра этой страницы.' }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  protected

    def current_user_subscribed?
      user_signed_in? && current_user.subscribed?
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:slug, :subscribe_at, :name])
    end

    def sbrf_action
      # @sbrf_client отправляет запросы на тестовый сервер эквайринга
      if Rails.env.production?
        @sbrf_client ||= SBRF::Acquiring::Client.new(username: Rails.application.credentials.dig(:sbrf, :username), password: Rails.application.credentials.dig(:sbrf, :password))
      else
        @sbrf_client ||= SBRF::Acquiring::Client.new(token: Rails.application.credentials.dig(:sbrf, :token_test), test: true)
      end
    end

    # def searchs
    #   @q = Article::Post.ransack(params[:q])
    # end

    def user_show
      @user_agent = User.where(:slug => request.subdomain).first
    end

    def summ_small_month
      "420"
    end
    def summ_large_month
      "740"
    end

end

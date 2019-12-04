module RescueFormConcern
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |record|
      respond_to do |format|
        format.json { head :forbidden, content_type: 'text/html' }
        format.html { redirect_to main_app.root_url, alert: 'Страница не найдена!' }
        format.js   { head :forbidden, content_type: 'text/html' }
      end
    end

    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.json { head :forbidden, content_type: 'text/html' }
        format.html { redirect_to main_app.root_url, alert: 'Вы не авторизованы для просмотра этой страницы.' }
        format.js   { head :forbidden, content_type: 'text/html' }
      end
    end
  end
end

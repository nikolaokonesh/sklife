module RescueFormConcern
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |_record|
      respond_to do |format|
        format.json { head :forbidden, content_type: 'text/html' }
        format.html do
          redirect_to main_app.root_url,
                      alert: 'Страница не найдена!'
        end
        format.js   { head :forbidden, content_type: 'text/html' }
      end
    end

    rescue_from CanCan::AccessDenied do |_exception|
      respond_to do |format|
        format.json { head :forbidden, content_type: 'text/html' }
        format.html do
          redirect_to main_app.root_url,
                      alert: 'Вы не авторизованы для просмотра этой страницы.'
        end
        format.js { head :forbidden, content_type: 'text/html' }
      end
    end
  end
end

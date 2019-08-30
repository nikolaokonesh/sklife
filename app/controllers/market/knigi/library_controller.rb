class Market::Knigi::LibraryController < ApplicationController
  before_action :authenticate_user!
  layout 'root/index'

  def index
    unless request.subdomain.present?
      @pagy, @library_books = pagy(current_user.library_additions, link_extra: 'data-remote="true"')
    else
      redirect_to root_url, alert: "Введите ссылку без поддомена: #{request.subdomain}"
    end
  end
end

class Market::Knigi::LibraryController < ApplicationController
  before_action :authenticate_user!
  layout 'root/index'

  def index
    unless request.subdomain.present?
      @library_books = current_user.library_additions.page params[:page].to_i
    else
      redirect_to root_url, alert: "Введите ссылку без поддомена: #{request.subdomain}"
    end
  end
end

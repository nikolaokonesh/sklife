module Market
  module Knigi
    class LibraryController < ApplicationController
      before_action :authenticate_user!
      layout 'root/index'

      def index
        if request.subdomain.present?
          redirect_to root_url, alert: "Введите ссылку без поддомена: #{request.subdomain}"
        else
          @library_books = current_user.library_additions.page(params[:page])
        end
      end
    end
  end
end

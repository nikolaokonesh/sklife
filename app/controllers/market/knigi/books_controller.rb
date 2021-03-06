module Market
  module Knigi
    class BooksController < ApplicationController
      before_action :set_book, only: %i[show edit update destroy library success]
      before_action :authenticate_user!, except: %i[index show]
      load_and_authorize_resource except: %i[index show library success fail]

      layout 'root/index'

      def index
        if request.subdomain.present?
          redirect_to root_url, alert: "Введите ссылку без поддомена: #{request.subdomain}"
        else
          books_include
        end
      end

      def show
        if request.subdomain.present?
          redirect_to root_url, alert: "Введите ссылку без поддомена: #{request.subdomain}"
        else
          @page = Market::Knigi::Page.new
          @pages = @book.pages.order(created_at: :asc)
        end
        respond_to do |format|
          format.html
          format.js
        end
      end

      def new
        if request.subdomain.present?
          redirect_to root_url, alert: 'Это не ваш домен...'
        else
          @book = current_user.books.build
        end
      end

      def create
        @book = current_user.books.build(book_params)
        if @book.save
          flash[:notice] = 'Категория успешно добавлена!'
        else
          render partial: 'error', locals: { post: @book }, status: :bad_request
        end
      end

      def edit
        if @book.user == current_user
        else
          redirect_to root_url, alert: 'Не ваша Категория!'
        end
      end

      def update
        if @book.user == current_user
          if @book.update(book_params)
            flash[:notice] = 'Пост успешно обновлен!'
          else
            render partial: 'error', locals: { post: @book }, status: :bad_request
          end
        else
          redirect_to root_url, alert: 'Ошибка. Вы не в своей странице!'
        end
      end

      def destroy
        if @book.user == current_user
          flash[:notice] = 'Страница успешно удалена!'
          DestroyJob.perform_later(@book)
        else
          redirect_to root_url, alert: 'Ошибка. Вы не в своей странице!'
        end
      end

      def library
        type = params[:type]
        if type == 'add'
          if @book.price == 0
            current_user.library_additions << @book
            redirect_to book_url(@book), "up-target" => ".main", notice: "Вы добавили книгу: #{@book.title}"
          else
            response = @sbrf_client.register(amount: params[:amountorub],
                                             order_number: SecureRandom.random_number(10_000_000_000),
                                             return_url: success_book_url(@book),
                                             fail_url: fail_book_url(@book))
            if response.success?
              redirect_to response.form_url, allow_other_host: true
            else
              redirect_to root_url, alert: 'Ошибка. Обратитесь к администратору'
            end
          end
        else
          redirect_to book_url(@book), notice: 'Looks like nothing happened. Try once more!'
        end
      end

      def success
        @libre = current_user.libraries.where(user: current_user, book: @book).any?
        if @libre
          redirect_to books_url, notice: 'Вы уже приобрели этот товар'
        else
          status = @sbrf_client.get_order_status_extended(order_id: params[:orderId])
          if status.success? && status.order_status == 2
            sbrf_order = Market::Knigi::Order.where(number: status.orderNumber).limit(1)
            if sbrf_order.present? == false
              current_user.book_orders.create(number: status.orderNumber,
                                              about: "книга: #{@book.title}",
                                              price: @book.price)
              current_user.library_additions << @book
              redirect_to books_url, notice: "Вы добавили книгу: #{@book.title}"
            else
              redirect_to books_url, alert: 'Данный запрос был ранее задан и обработан.'
            end
          else
            redirect_to books_url, alert: status.error_message
          end
        end
      end

      def fail
        redirect_to books_url, alert: 'Fail'
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_book
        @book = book_scope.friendly.find(params[:id])
      end

      def book_scope
        Market::Knigi::Book
      end

      def books_include
        @books = if user_signed_in? && current_user.admin?
                   book_scope.order(created_at: :desc).page(params[:page])
                 else
                   book_scope.order(created_at: :desc).where(public: true).page(params[:page])
                 end
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def book_params
        params.require(:book).permit(:title, :body_book, :author, :price, :data, :public)
      end
    end
  end
end

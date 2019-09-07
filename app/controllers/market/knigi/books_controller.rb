class Market::Knigi::BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :library, :success]
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource except: [:index, :show, :library, :success, :fail]
  layout 'root/index'

  def index
    unless request.subdomain.present?
      if user_signed_in? && current_user.admin?
        @pagy, @books = pagy(book_scope.order(created_at: :desc), link_extra: 'data-remote="true"')
      else
        @pagy, @books = pagy(book_scope.order(created_at: :desc).where(public: true), link_extra: 'data-remote="true"')
      end
    else
      redirect_to root_url, alert: "Введите ссылку без поддомена: #{request.subdomain}"
    end
  end

  def show
    unless request.subdomain.present?
      @page = Market::Knigi::Page.new
      @pages = @book.pages.order(created_at: :asc)
    else
      redirect_to root_url, alert: "Введите ссылку без поддомена: #{request.subdomain}"
    end
  end

  def new
    unless request.subdomain.present?
      @book = current_user.books.build
    else
      redirect_to root_url, alert: 'Это не ваш домен...'
    end
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:notice] = 'Категория успешно добавлена!'
    else
      render partial: 'error', book: @book, status: :bad_request
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
        render partial: 'error', book: @book, status: :bad_request
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

    if type == "add"
      response = @sbrf_client.register(
        amount: params[:amountorub], # в самых мелких долях валюты
        order_number: SecureRandom.random_number(10000000000),
        return_url: success_book_url(@book),
        fail_url: fail_book_url(@book)
      )
      if response.success?
        redirect_to response.form_url, allow_other_host: true
      else
        redirect_to root_url, alert: 'Ошибка. Обратитесь к администратору'
      end
    else
      redirect_to book_url(@book), notice: "Looks like nothing happened. Try once more!"
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
          current_user.book_orders.create(
            number: status.orderNumber,
            about: "книга: #{@book.title}",
            price: @book.price)
          current_user.library_additions << @book
          redirect_to books_url, notice: "Вы добавили в библиотеку книгу: #{@book.title}"
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
    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :author, :price, :data, :public)
    end
end

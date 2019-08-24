class Market::Knigi::Books::PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]
  before_action :set_commentable
  # load_and_authorize_resource except: [:index, :show]
  layout 'root/index'

  def show
    unless request.subdomain.present?
      @pages = @page.commentable.pages.order(created_at: :asc)
    else
      redirect_to root_url, alert: "Введите ссылку без поддомена: #{request.subdomain}"
    end
  end

  def create
    @page = @commentable.pages.new(page_params)
    if @page.save
      flash[:notice] = 'Страница успешно добавлена!'
    else
      render partial: 'error', page: @page, status: :bad_request
    end
    authorize! :manage, @page
  end

  def edit
    if @commentable.user == current_user
    else
      redirect_to root_url, alert: 'Не вами добавлена книга!'
    end
    authorize! :manage, @page
  end
  def update
    if @commentable.user == current_user
      if @page.update(page_params)
        flash[:notice] = 'Страница успешно обновлена!'
      else
        render partial: 'error', page: @page, status: :bad_request
      end
    else
      redirect_to root_url, alert: 'Ошибка. Вы не в своей добавленной книге!'
    end
    authorize! :manage, @page
  end

  def destroy
    if @commentable.user == current_user
      flash[:notice] = 'Страница успешно удалена!'
      @page.destroy
      redirect_to @commentable, notice: "Страница успешно удалена!"
    else
      redirect_to root_url, alert: 'Ошибка. Вы не в своей странице!'
    end
    authorize! :manage, @page
  end

  private
    def set_page
      @page = Market::Knigi::Page.find(params[:id])
    end

    def set_commentable
      @commentable = Market::Knigi::Book.friendly.find(params[:book_id])
    end

    def page_params
      params.require(:page).permit(:title, :body, :commentable_id)
    end
end

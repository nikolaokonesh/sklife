class Article::CategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :people]
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  layout 'root/index'

  def index
    @posts = Article::Post.where(type: nil).order(created_at: :desc).page params[:page].to_i
    # @articles_people = Blog::Post.includes(:user, :comments).order(created_at: :desc).page params[:peop].to_i
    @comments = Comment.order(created_at: :desc).where.not(user: nil).where(user_agent: nil).page params[:comments].to_i
    # @projects = Project.order(created_at: :desc).page params[:projects].to_i
    # if user_signed_in? && current_user.admin?
    #   @books = Book.order(created_at: :desc).page params[:books].to_i
    # else
    #   @books = Book.order(created_at: :desc).where(public: true).page params[:books].to_i
    # end
  end

  def show
    unless request.subdomain.present?
      @post = Article::Post.new
      @posttable = @category
      @posts = @category.posts.includes(:user, :comments).order(created_at: :desc).page params[:page].to_i

      if @category.no_comments.present?
        @comments = if params[:comment]
                      @category.comments.where(id: params[:comment])
                    else
                      @category.comments.where(parent_id: nil)
                    end
        @comments = @comments.includes(:user).order(created_at: :desc).page params[:pagina].to_i

        if @category.comments.present?
          @comments_parent = @category.comments.order(created_at: :desc).where(id: @comments.first.parent_id)
        end
      end
    else
      redirect_to root_url, alert: "Введите ссылку без поддомена: #{request.subdomain}"
    end
  end

  def new
    unless request.subdomain.present?
      @category = category_scope.new
      @category.youtubes.new
    else
      redirect_to root_url, alert: 'Это не ваш домен...'
    end
    authorize! :manage, @category
  end

  def create
    @category = category_scope.new(category_params)
    @category.user = current_user
    if @category.save
      flash[:notice] = 'Категория успешно добавлена!'
    else
      render partial: 'error', category: @category, status: :bad_request
    end
    authorize! :manage, @category
  end

  def edit
    if @category.user == current_user
    else
      redirect_to root_url, alert: 'Не ваша Категория!'
    end
    authorize! :manage, @category
  end

  def update
    if @category.user == current_user
      @category_slug = @category.slug
      if @category.update(category_params)
        @category.update(upgrade: @category.updated_at)
        unless @category.slug == @category_slug
          if @category.posts.present?
            @category.posts.update_all(updated_at: @category.updated_at)
          end
        end
        flash[:notice] = 'Пост успешно обновлен!'
      else
        render partial: 'error', category: @category, status: :bad_request
      end
    else
      redirect_to root_url, alert: 'Ошибка. Вы не в своей странице!'
    end
    authorize! :manage, @category
  end

  def destroy
    if @category.user == current_user
      flash[:notice] = 'Страница успешно удалена!'
      DestroyJob.perform_later(@category)
    else
      redirect_to root_url, alert: 'Ошибка. Вы не в своей странице!'
    end
    authorize! :manage, @category
  end

  private

    def set_category
      @category = category_scope.friendly.find(params[:id])
    end

    def category_scope
      Article::Category
    end

    def category_params
      params.require(:category).permit(:title, :body, :no_data, :no_comments, youtubes_attributes: [:id, :url, :_destroy])
    end
end

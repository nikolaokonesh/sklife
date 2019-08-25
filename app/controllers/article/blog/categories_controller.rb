class Article::Blog::CategoriesController < Article::CategoriesController
  before_action :authenticate_user!, except: [:index, :show, :people]
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  layout 'blog/index'

  def index
    @posts = @user_agent.posts.includes(:user, :comments).where(type: 'Article::Blog::Post').order(created_at: :desc).page params[:page].to_i
    # @comments = Comment.order(created_at: :desc).where.not(user: nil, user_agent: nil).where(user_agent: @user_agent.id).page params[:comments].to_i
  end

  def show
    if @category.user == @user_agent
      @post = Article::Blog::Post.new
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
      redirect_to root_url, alert: 'В этом домене такого нет...'
    end
  end

  def new
    if current_user.subscribed?
      if @user_agent == current_user
        @category = category_scope.new
        @category.youtubes.new
      else
        redirect_to root_url, alert: 'Это не ваш домен...'
      end
    else
      redirect_to subscribes_path, alert: 'Доступно только для подписчиков!'
    end
  end

  def edit
    if current_user.subscribed?
      if @user_agent == current_user && @category.user == current_user
      else
        redirect_to root_url, alert: 'Не ваша Категория!'
      end
    else
      redirect_to subscribes_url, alert: 'Доступно только для подписчиков!'
    end
  end

  private

    def set_category
      @category = category_scope.friendly.find(params[:id])
    end

    def category_scope
      Article::Blog::Category
    end

end

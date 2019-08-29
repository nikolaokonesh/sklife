class Article::Blog::PostsController < Article::PostsController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  layout 'blog/index'

  def show
    if @post.user == @user_agent
      @pagy, @posts = pagy(@post.posttable.posts.includes(:user, :comments).order(created_at: :desc).where.not(id: @post.id), link_extra: 'data-remote="true"')

      @comments = if params[:comment]
                    @post.comments.where(id: params[:comment])
                  else
                    @post.comments.where(parent_id: nil)
                  end
      @pagy_comment, @comments = pagy(@comments.includes(:user).order(created_at: :desc), page_param: :pagina, link_extra: 'data-remote="true"')

      if @post.comments.present?
        @comments_parent = @post.comments.order(created_at: :desc).where(id: @comments.first.parent_id)
      end
    else
      redirect_to root_url, alert: 'В этом домене такого нет...'
    end
  end

  def new
    if current_user.subscribed?
      if @user_agent == current_user
        @post = post_scope.new
        @post.youtubes.new
      else
        redirect_to root_url, alert: 'Это не ваш домен...'
      end
    else
      redirect_to subscribes_url, alert: 'Доступно только для подписчиков!'
    end
  end

  def create
    if @posttable.user == current_user
      @post = @posttable.posts.new(post_params)
      @post.user = current_user
      if @post.save
        @posttable.update(upgrade: @posttable.updated_at)
        flash[:notice] = 'Пост успешно добавлен!'
      else
        render partial: 'error', post: @post, status: :bad_request
      end
    else
      raise ActionController::RoutingError.new('User Not Found')
    end
  end

  def edit
    if current_user.subscribed?
      if @post.user == current_user
      else
        redirect_to root_url, alert: 'Не ваша Категория!'
      end
    else
      redirect_to subscribes_url, alert: 'Доступно только для подписчиков!'
    end
  end

  private

    def set_post
      @post = post_scope.friendly.find(params[:id])
    end

    def post_scope
      Article::Blog::Post
    end

    def post_params
      params.require(:post).permit(:title, :body, :posttable_id, :no_comments, youtubes_attributes: [:id, :url, :_destroy])
    end
end

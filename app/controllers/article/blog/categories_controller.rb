class Article::Blog::CategoriesController < Article::CategoriesController
  before_action :authenticate_user!, except: [:index, :show, :people]
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  layout :determine_layout

  def index
    if @user_agent.present?
      # @comments = Comment.order(created_at: :desc).where.not(user: nil, user_agent: nil).where(user_agent: @user_agent.id).page params[:comments].to_i
      @pagy, @posts = pagy(@user_agent.posts.includes(:posttable, :comments).with_rich_text_body_post_and_embeds.where(type: 'Article::Blog::Post').order(created_at: :desc), link_extra: 'data-remote="true"')
    else
      redirect_to root_url(subdomain: false), alert: 'Неправильно ввели ссылку. Попробуйте еще.'
    end
  end

  def show
    if @category.user == @user_agent
      @post = Article::Blog::Post.new
      @posttable = @category
      @pagy, @posts = pagy(@category.posts.includes(:user, :comments).with_rich_text_body_post_and_embeds.order(created_at: :desc), link_extra: 'data-remote="true"')
      if @category.no_comments.present?
        @comments = if params[:comment]
                      @category.comments.where(id: params[:comment])
                    else
                      @category.comments.where(parent_id: nil)
                    end
        @pagy_comment, @comments = pagy(@comments.includes(:user, :rich_text_body_comment).order(created_at: :desc), page_param: :pagina, link_extra: 'data-remote="true"')
        if @category.comments.present?
          @comments_parent = @category.comments.order(created_at: :desc).where(id: @comments.first.parent_id)
        end
      end
    else
      redirect_to root_url, alert: 'Такой страницы не существует!'
    end
  end

  def new
    if current_user.newsubscribed?
      if @user_agent == current_user
        @category = category_scope.new
        @category.youtubes.new
      else
        redirect_to root_url, alert: 'Это не ваш домен...'
      end
    else
      redirect_to main_app.url_for(controller: '/static', action: :show, page: :subscribes, subdomain: false), alert: 'Доступно только для подписчиков!'
    end
  end

  def edit
    if current_user.newsubscribed?
      if @user_agent == current_user && @category.user == current_user
      else
        redirect_to root_url, alert: 'Не ваша Категория!'
      end
    else
      redirect_to main_app.url_for(controller: '/static', action: :show, page: :subscribes, subdomain: false), alert: 'Доступно только для подписчиков!'
    end
  end

  private

    def determine_layout
      %w(show new edit).include?(action_name) ? "blog/show" : "blog/index"
    end

    def set_category
      @category = category_scope.friendly.find(params[:id])
    end

    def category_scope
      Article::Blog::Category
    end

end

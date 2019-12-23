module Article
  module Blog
    class CategoriesController < Article::CategoriesController
      before_action :authenticate_user!, except: %i[index show people]
      before_action :set_category, only: %i[show edit update destroy]
      layout :determine_layout

      include CategoryShowConcern

      def index
        if @user_agent.present?
          @posts = @user_agent.posts.includes(:posttable, :comments).with_rich_text_body_post_and_embeds
                              .where(type: 'Article::Blog::Post').order(created_at: :desc).page(params[:page])
        else
          redirect_to root_url(subdomain: false), alert: 'Неправильно ввели ссылку. Попробуйте еще.'
        end
      end

      def show
        if @category.user == @user_agent
          @post = Article::Blog::Post.new
          category_show_conc
        else
          redirect_to root_url, alert: 'Страница не найдена!'
        end
      end

      def new
        return '' unless current_user.newsubscribed?

        if @user_agent == current_user
          @category = category_scope.new
          @category.youtubes.new
        else
          redirect_to root_url, alert: 'Это не ваш домен...'
        end
      end

      def edit
        if current_user.newsubscribed?
          if @user_agent == current_user && @category.user == current_user
          else
            redirect_to root_url, alert: 'Не ваша Категория!'
          end
        else
          redirect_to main_app.url_for(controller: '/static', action: :show, page: :subscribes, subdomain: false),
                      alert: 'Доступно только для подписчиков!'
        end
      end

      private

      def determine_layout
        %w[show new edit].include?(action_name) ? 'blog/show' : 'blog/index'
      end

      def set_category
        @category = category_scope.friendly.find(params[:id])
      end

      def category_scope
        Article::Blog::Category
      end
    end
  end
end

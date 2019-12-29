module Article
  module Blog
    class PostsController < Article::PostsController
      before_action :authenticate_user!, except: %i[index show]
      before_action :set_post, only: %i[show edit update destroy]
      layout :determine_layout

      include PostShowConcern

      def show
        if @post.type == post_scope.to_s
          if @post.user == @user_agent
            post_show_conc
          else
            redirect_to root_url, alert: 'Страница не найдена!'
          end
        else
          redirect_to root_url, alert: 'Страница не найдена!'
        end
      end

      def new
        return '' unless current_user.newsubscribed?

        posts_cope_new
      end

      def create
        return redirect_to_subscribes unless current_user.newsubscribed?

        if @posttable.user == current_user
          posttable_posts_new
        else
          redirect_to root_url, alert: 'Упс! Это не ваш домен...'
        end
      end

      def edit
        if current_user.newsubscribed?
          if @post.user == current_user
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

      def set_post
        @post = post_scope.friendly.find(params[:id])
      end

      def posttable_posts_new
        @post = @posttable.posts.new(post_params)
        @post.user = current_user
        if @post.save
          @posttable.update(upgrade: @posttable.updated_at)
          flash[:notice] = 'Пост успешно добавлен!'
        else
          render partial: 'error', locals: { post: @post }, status: :bad_request
        end
      end

      def posts_cope_new
        if @user_agent == current_user
          @post = post_scope.new
          @post.youtubes.new
        else
          redirect_to root_url, alert: 'Это не ваш домен...'
        end
      end

      def redirect_to_subscribes
        redirect_to main_app.url_for(controller: '/static', action: :show, page: :subscribes, subdomain: false),
                    alert: 'Доступно только для подписчиков!'
      end

      def post_scope
        Article::Blog::Post
      end

      def post_params
        params.require(:post).permit(:title, :body_post, :description, :posttable_id, :no_comments, :top,
                                     youtubes_attributes: %i[id url user_id _destroy])
      end
    end
  end
end

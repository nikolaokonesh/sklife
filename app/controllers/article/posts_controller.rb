module Article
  class PostsController < ApplicationController
    before_action :authenticate_user!, except: %i[index show]
    before_action :set_post, only: %i[show edit update destroy]
    layout 'root/index'

    include PostShowConcern

    def show
      if request.subdomain.present?
        redirect_to root_url, alert: 'Страница не найдена!'
      elsif @post.type.nil?
        post_show_conc
      else
        redirect_to root_url, alert: 'Страница не найдена!'
      end
    end

    def new
      if request.subdomain.present?
        redirect_to root_url, alert: "Введите ссылку без поддомена: #{request.subdomain}"
      else
        @post = post_scope.new
        @post.youtubes.new
      end
      authorize! :manage, @post
    end

    def create
      @post = @posttable.posts.new(post_params)
      @post.user = current_user
      if @post.save
        @posttable.update(upgrade: @posttable.updated_at)
        flash[:notice] = 'Пост успешно добавлен!'
      else
        render partial: 'error', post: @post, status: :bad_request
      end
      authorize! :manage, @post
    end

    def edit
      if request.subdomain.present?
        redirect_to root_url, alert: "Введите ссылку без поддомена: #{request.subdomain}"
      elsif @post.user == current_user
      else
        redirect_to root_url, alert: 'Ошибка. Вы не в своей странице!'
      end
      authorize! :manage, @post
    end

    def update
      if @post.user == current_user
        if @post.update(post_params)
          flash[:notice] = 'Пост успешно обновлен!'
        else
          render partial: 'error', post: @post, status: :bad_request
        end
      else
        redirect_to root_url, alert: 'Ошибка. Вы не в своей странице!'
      end
      authorize! :manage, @post
    end

    def destroy
      if @post.user == current_user
        flash[:notice] = 'Страница успешно удалена!'
        DestroyJob.perform_later(@post)
      else
        redirect_to root_url, alert: 'Ошибка. Вы не в своей странице!'
      end
      authorize! :manage, @post
    end

    private

    def set_post
      @post = post_scope.friendly.find(params[:id])
    end

    def post_scope
      Article::Post
    end

    def post_params
      params.require(:post).permit(:title, :body_post, :posttable_id, :no_comments, :top, :subscribe,
                                   youtubes_attributes: %i[id url user_id _destroy])
    end
  end
end

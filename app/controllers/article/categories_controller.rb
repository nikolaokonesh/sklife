module Article
  class CategoriesController < ApplicationController
    before_action :authenticate_user!, except: %i[index show people]
    before_action :set_category, only: %i[show edit update destroy]
    layout 'root/index'

    include CategoryShowConcern

    def index
      @posts = Article::Post.includes(:posttable, :comments, :user, :rich_text_body_post)
                            .with_rich_text_body_post_and_embeds.where(top: true).order(created_at: :desc)
                            .page(params[:page])
    end

    def show
      if @category.type.nil?
        @post = Article::Post.new
        category_show_conc
      else
        redirect_to root_url, alert: 'Страница не найдена!'
      end
    end

    def new
      if request.subdomain.present?
        redirect_to root_url, alert: 'Это не ваш домен!'
      else
        @category = category_scope.new
        @category.youtubes.new
      end
      authorize! :manage, @category
    end

    def create
      @category = category_scope.new(category_params)
      @category.user = current_user
      if @category.save
        flash[:notice] = 'Категория успешно добавлена!'
      else
        render partial: 'error', locals: { post: @category }, status: :bad_request
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
        if @category.update(category_params)
          category_upgrade
        else
          render partial: 'error', locals: { post: @category }, status: :bad_request
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

    def category_upgrade
      @category.update(description: @category.body.to_plain_text.to_s[0..200])
      @category.update(upgrade: @category.updated_at)
      @category.posts.update_all(updated_at: @category.updated_at) if @category.posts.present?
      flash[:notice] = 'Пост успешно обновлен!'
    end

    def category_scope
      Article::Category
    end

    def category_params
      params.require(:category).permit(:title, :body, :description, :no_data, :no_comments,
                                       youtubes_attributes: %i[id url user_id _destroy])
    end
  end
end

class Article::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search, :searching]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  layout 'root/index'

  def show
    unless request.subdomain.present?
      if @post.type == nil
        @posts = @post.posttable.posts.includes(:comments).with_rich_text_body_post.order(created_at: :desc).where.not(id: @post.id).page(params[:page])
        if @post.no_comments.present?
          @comments = if params[:comment]
                        @post.comments.where(id: params[:comment])
                      else
                        @post.comments.where(parent_id: nil)
                      end
          @comments = @comments.includes(:user).with_rich_text_body_comment.order(created_at: :desc).page(params[:pagina])
          if @post.comments.present?
            @comments_parent = @post.comments.order(created_at: :desc).where(id: @comments.first.parent_id)
          end
        end
      else
        redirect_to root_url, alert: "Страница не найдена!"
      end
    else
      redirect_to root_url, alert: "Страница не найдена!"
    end
  end

  def new
    unless request.subdomain.present?
      @post = post_scope.new
      @post.youtubes.new
    else
      redirect_to root_url, alert: "Введите ссылку без поддомена: #{request.subdomain}"
    end
    authorize! :manage, @post
  end

  def create
    @post = @posttable.posts.new(post_params)
    @post.user = current_user
    if @post.save
      @posttable.update(upgrade: @posttable.updated_at)
      # @post.image.attach(attach_param) if attach_param.present?
      flash[:notice] = 'Пост успешно добавлен!'
    else
      render partial: 'error', post: @post, status: :bad_request
    end
    authorize! :manage, @post
  end

  def edit
    unless request.subdomain.present?
      if @post.user == current_user
      else
        redirect_to root_url, alert: 'Ошибка. Вы не в своей странице!'
      end
    else
      redirect_to root_url, alert: "Введите ссылку без поддомена: #{request.subdomain}"
    end
    authorize! :manage, @post
  end

  def update
    if @post.user == current_user
      if @post.update(post_params)
        # @post.image.attach(attach_param) if attach_param.present?
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

  def searching
    @posts = @q.result.includes(:comments).order(created_at: :desc).page params[:page].to_i
  end

  def search
    searching
    render :searching
  end

  private

    def set_post
      @post = post_scope.friendly.find(params[:id])
    end

    def post_scope
      Article::Post
    end

    def post_params
      params.require(:post).permit(:title, :body_post, :posttable_id, :no_comments, :top, :subscribe, youtubes_attributes: [:id, :url, :user_id, :_destroy])
    end
end

module PostShowConcern
  extend ActiveSupport::Concern

  included do
    def post_show_conc
      post_posttsble_post
      comments_post
      post_comments_present if @post.comments.present?
    end
  end

  def post_posttsble_post
    @posts = @post.posttable.posts.includes(:comments).with_rich_text_body_post.order(created_at: :desc)
                  .where.not(id: @post.id).page(params[:page])
  end

  def comments_post
    @comments = if params[:comment]
                  @post.comments.where(id: params[:comment])
                else
                  @post.comments.where(parent_id: nil)
                end
    @comments = @comments.includes(:user).with_rich_text_body_comment.order(created_at: :desc).page(params[:pagina])
  end

  def post_comments_present
    @comments_parent = @post.comments.order(created_at: :desc).where(id: @comments.first.parent_id)
  end
end

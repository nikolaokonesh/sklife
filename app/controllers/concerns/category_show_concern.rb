module CategoryShowConcern
  extend ActiveSupport::Concern

  included do
    def category_show_conc
      @posttable = @category
      category_posts
      comments_category
      category_comments_present if @category.comments.present?
    end
  end

  def category_posts
    @posts = @category.posts.includes(:comments).with_rich_text_body_post_and_embeds.order(created_at: :desc)
                      .page(params[:page])
  end

  def comments_category
    @comments = if params[:comment]
                  @category.comments.where(id: params[:comment])
                else
                  @category.comments.where(parent_id: nil)
                end
    @comments = @comments.includes(:user).with_rich_text_body_comment.order(created_at: :desc).page(params[:pagina])
  end

  def category_comments_present
    @comments_parent = @category.comments.order(created_at: :desc).where(id: @comments.first.parent_id)
  end
end

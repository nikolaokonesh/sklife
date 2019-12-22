module CategoryShowConcern
  extend ActiveSupport::Concern

  included do
    @posttable = @category
    @posts = @category.posts.includes(:comments).with_rich_text_body_post_and_embeds.order(created_at: :desc)
                            .page(params[:page])
    if @category.no_comments.present?
      @comments = if params[:comment]
                    @category.comments.where(id: params[:comment])
                  else
                    @category.comments.where(parent_id: nil)
                  end
      @comments = @comments.includes(:user).with_rich_text_body_comment.order(created_at: :desc).page(params[:pagina])
      if @category.comments.present?
        @comments_parent = @category.comments.order(created_at: :desc).where(id: @comments.first.parent_id)
      end
    end
  end
end

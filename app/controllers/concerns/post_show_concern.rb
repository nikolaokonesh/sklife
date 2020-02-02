module PostShowConcern
  extend ActiveSupport::Concern

  included do
    def post_show_conc
      @posts = @post.posttable.posts.includes(:comments).with_rich_text_body_post.order(created_at: :desc).page(params[:page])
      @comments = if params[:comment]
                    @post.comments.where(id: params[:comment])
                  else
                    @post.comments.where(parent_id: nil)
                  end
      @comments = @comments.includes(:user).with_rich_text_body_comment.order(created_at: :desc).page(params[:pagina])

      # if @post.comments.present?
      #   @comments_parent = @post.comments.order(created_at: :desc).where(id: @comments.first.parent_id)
      # end
    end
  end
end

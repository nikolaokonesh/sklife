class Article::Blog::Categories::CommentsController < CommentsController
  before_action :set_commentable

  private

    def set_commentable
      @commentable = Article::Blog::Category.friendly.find(params[:category_id])
    end
end

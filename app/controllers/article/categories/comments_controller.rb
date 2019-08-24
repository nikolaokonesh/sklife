class Article::Categories::CommentsController < CommentsController
  before_action :set_commentable

  private

    def set_commentable
      @commentable = Article::Category.friendly.find(params[:category_id])
    end

end

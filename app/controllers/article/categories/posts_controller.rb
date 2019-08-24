class Article::Categories::PostsController < Article::PostsController
  before_action :set_posttable

  private

    def set_posttable
      @posttable = Article::Category.friendly.find(params[:category_id])
    end

end

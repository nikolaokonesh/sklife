module Article
  module Blog
    module Categories
      class PostsController < Article::Blog::PostsController
        before_action :set_posttable

        private

        def set_posttable
          @posttable = Article::Blog::Category.friendly.find(params[:category_id])
        end
      end
    end
  end
end

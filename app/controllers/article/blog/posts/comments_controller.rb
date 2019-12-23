module Article
  module Blog
    module Posts
      class CommentsController < CommentsController
        before_action :set_commentable

        private

        def set_commentable
          @commentable = Article::Blog::Post.friendly.find(params[:post_id])
        end
      end
    end
  end
end

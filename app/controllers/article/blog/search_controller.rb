module Article
  module Blog
    class SearchController < Article::SearchController
      def index
        @post = @user_agent.posts.search(params[:query]).where(type: 'Article::Blog::Post').limit(10)
        render layout: false
      end
    end
  end
end

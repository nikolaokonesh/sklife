module Article
  class SearchController < ApplicationController
    def index
      @post = Article::Post.search(params[:query]).where(top: true).limit(10)
      render layout: false
    end
  end
end

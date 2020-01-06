module Market
  module Knigi
    class BooksearchController < ApplicationController
      def index
        @book = Market::Knigi::Book.search(params[:query]).where(public: true).limit(10)
        render layout: false
      end
    end
  end
end

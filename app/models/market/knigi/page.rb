module Market
  module Knigi
    class Page < ApplicationRecord
      validates :title,
                presence: true,
                length: { minimum: 3, maximum: 350 }

      has_rich_text :body_page
      validates :body_page,
                length: { maximum: 32_000 }

      belongs_to :commentable, polymorphic: true, touch: true

      has_many :views, dependent: :destroy, class_name: 'Market::Knigi::View'

      def next(post)
        Market::Knigi::Page.where('id > ?', id).where(commentable: post.commentable)
                           .order(id: :asc).limit(1).first
      end

      def prev(post)
        Market::Knigi::Page.where('id < ?', id).where(commentable: post.commentable)
                           .order(id: :desc).limit(1).first
      end
    end
  end
end

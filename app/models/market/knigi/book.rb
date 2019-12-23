module Market
  module Knigi
    class Book < ApplicationRecord
      validates :title,
                presence: true,
                length: { minimum: 3, maximum: 350 }
      validates_presence_of :user_id

      include SlugConcern

      belongs_to :user
      has_many :libraries, class_name: 'Market::Knigi::Library'
      has_many :added_books, through: :libraries, source: :user
      has_many :pages, as: :commentable, dependent: :destroy, class_name: 'Market::Knigi::Page'

      def publication
        'Не завершено' if public.blank?
      end
    end
  end
end

module Market
  module Knigi
    class Library < ApplicationRecord
      belongs_to :book, touch: true, class_name: 'Market::Knigi::Book'
      belongs_to :user
    end
  end
end

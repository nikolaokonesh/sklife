class Market::Knigi::Page < ApplicationRecord

  validates :title,
            presence: true,
            length: { minimum: 3, maximum: 150 }

  has_rich_text :body
  validates :body,
            length: { maximum: 32000 }

  belongs_to :commentable, polymorphic: true, touch: true

  has_many :views, dependent: :destroy, class_name: 'Market::Knigi::View'

end

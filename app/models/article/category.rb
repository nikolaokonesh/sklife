class Article::Category < ApplicationRecord
  include InputConcern
  include SlugConcern
  include UpgradeConcern
  include YoutubeConcern

  has_rich_text :body
  validates :body, length: { maximum: 32000 }

  belongs_to :user, touch: true
  has_many :posts, as: :posttable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
end

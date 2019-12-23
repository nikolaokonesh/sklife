module Article
  class Post < ApplicationRecord
    include InputConcern
    include SlugConcern
    include UpgradeConcern
    include YoutubeConcern

    has_rich_text :body_post
    validates_presence_of :body_post
    validates :body_post, length: { maximum: 32_000 }

    belongs_to :user, touch: true
    belongs_to :posttable, polymorphic: true, touch: true
    has_many :comments, as: :commentable, dependent: :destroy
  end
end

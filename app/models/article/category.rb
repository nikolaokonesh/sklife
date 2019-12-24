module Article
  class Category < ApplicationRecord
    include InputConcern
    include SlugConcern
    include UpgradeConcern
    include YoutubeConcern

    has_rich_text :body

    belongs_to :user, touch: true
    has_many :posts, as: :posttable, dependent: :destroy
    has_many :comments, as: :commentable, dependent: :destroy

    def subscribe?
      false
    end
  end
end

module Article
  module Blog
    class Category < Article::Category
      include InputConcern
      include SlugConcern
      include UpgradeConcern
      include YoutubeConcern

      has_rich_text :body
      validates :body, length: { maximum: 200_000 }

      belongs_to :user, touch: true
      has_many :posts, as: :posttable, dependent: :destroy
      has_many :comments, as: :commentable, dependent: :destroy

      def subscribe?
        false
      end

      after_create :descript_create

      def descript_create
        update_attribute(:description, body.to_plain_text.to_s[0..200])
        save!
      end
    end
  end
end

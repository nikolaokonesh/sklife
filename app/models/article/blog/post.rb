module Article
  module Blog
    class Post < Article::Post
      include InputConcern
      include SlugConcern
      include UpgradeConcern
      include YoutubeConcern

      has_rich_text :body_post
      validates_presence_of :body_post

      belongs_to :user, touch: true
      belongs_to :posttable, polymorphic: true, touch: true
      has_many :comments, as: :commentable, dependent: :destroy
    end
  end
end

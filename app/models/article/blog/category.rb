class Article::Blog::Category < Article::Category
  include InputConcern
  include SlugConcern
  include UpgradeConcern
  include YoutubeConcern

  has_rich_text :body
  validates :body, length: { maximum: 3500 }

  belongs_to :user
  has_many :posts, as: :posttable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
end

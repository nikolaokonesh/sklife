class Article::Blog::Category < Article::Category
  include InputConcern
  include SlugConcern
  include UpgradeConcern

  belongs_to :user
  has_many :posts, as: :posttable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
end

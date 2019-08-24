class Article::Blog::Post < Article::Post
  include InputConcern
  include SlugConcern
  include UpgradeConcern

  belongs_to :user
  belongs_to :posttable, polymorphic: true, touch: true
  has_many :comments, as: :commentable, dependent: :destroy
end

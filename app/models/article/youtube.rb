class Article::Youtube < Youtube
  validates :url, url: { schemes: ['https'] }

  belongs_to :commentable, polymorphic: true, touch: true
  belongs_to :user

  def uid
    url.to_s[-11..-1]
  end
end

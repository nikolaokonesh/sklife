class Article::Subscribe < Order
  belongs_to :user, touch: true
end

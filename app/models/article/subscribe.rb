module Article
  class Subscribe < Order
    belongs_to :user, touch: true
  end
end

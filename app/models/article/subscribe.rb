module Article
  class Subscribe < Order
    belongs_to :user, touch: true, class_name: 'User'
  end
end

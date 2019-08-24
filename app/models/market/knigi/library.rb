class Market::Knigi::Library < ApplicationRecord

  belongs_to :book, touch: true
  belongs_to :user

end

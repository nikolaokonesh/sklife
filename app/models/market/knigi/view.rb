class Market::Knigi::View < ApplicationRecord

  belongs_to :page, class_name: 'Market::Knigi::Page'
  belongs_to :user

end

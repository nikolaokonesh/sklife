module Market
  module Knigi
    class Order < Order
      belongs_to :user
    end
  end
end

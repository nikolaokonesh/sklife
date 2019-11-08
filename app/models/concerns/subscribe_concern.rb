module SubscribeConcern
  extend ActiveSupport::Concern

  included do
    before_create :subscribe_create_date
    def subscribe_create_date
      self.subscribe_at = Date.today # + 1.week
    end
    # Подписка
    def subscribed?
      Date.parse(subscribe_at.to_s) > Date.today
    end
    # Бесплатно подписка впервые зарегистрированному
    def newsubscribed?
      Date.parse(subscribe_at.to_s) + 2.weeks > Date.today
    end
  end
end

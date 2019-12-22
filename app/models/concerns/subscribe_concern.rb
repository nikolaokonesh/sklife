module SubscribeConcern
  extend ActiveSupport::Concern

  included do
    before_create :subscribe_create_date
    def subscribe_create_date
      self.subscribe_at = Date.today # + 1.week
    end
    # Subscribes
    def subscribed?
      Date.parse(subscribe_at.to_s) > Date.today
    end
    # Free subscribe first user registration
    def newsubscribed?
      Date.parse(subscribe_at.to_s) + 1.week > Date.today
    end
  end
end

module Notifications
  module Model
    extend ActiveSupport::Concern

    included do
      belongs_to :actor, class_name: 'User', optional: true
      belongs_to :user, class_name: 'User'

      belongs_to :target, polymorphic: true, optional: true
      belongs_to :second_target, polymorphic: true, optional: true
      belongs_to :third_target, polymorphic: true, optional: true
    end

    def read?
      self.read_at.present?
    end

    module ClassMethods
      def read!(ids = [])
        return if ids.blank?
        Notification.where(id: ids).update_all(read_at: Time.now)
      end

      def unread_count(user)
        Notification.where(user: user).unread.count
      end
    end
  end
end

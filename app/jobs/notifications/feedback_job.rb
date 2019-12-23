module Notifications
  class FeedbackJob < ApplicationJob
    queue_as :default

    def perform(admin, user, feedback_id)
      Notification.create(user: admin, actor: user, target: feedback_id,
                          notify_type: 'feedback/feedback')
    end
  end
end

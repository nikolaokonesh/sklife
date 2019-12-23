module Notifications
  class CommentJob < ApplicationJob
    queue_as :default

    def perform(postst, current_user, commentst, posted)
      if commentst.parent_id.present?
        Comment.where(id: commentst.parent_id.to_s).each do |comment|
          if comment.user != current_user
            Notification.create(user: comment.user, actor: current_user, target: commentst, notify_type: posted.to_s)
          end
        end
      elsif postst.user != current_user
        Notification.create(user: postst.user, actor: current_user, target: commentst, notify_type: posted.to_s)
      end
    end
  end
end

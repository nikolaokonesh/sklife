class Notifications::CommentJob < ApplicationJob
  queue_as :default

  def perform(postst, current_user, commentst, posted)

    # retry with comment
    if commentst.parent_id.present?
      Comment.where(id: "#{commentst.parent_id}").each do |comment|
        if comment.user != current_user
          Notification.create(user: comment.user, actor: current_user, target: commentst, notify_type: "#{posted}")
        end
      end
    # only user the post comment
    elsif postst.user != current_user
      Notification.create(user: postst.user, actor: current_user, target: commentst, notify_type: "#{posted}")
    end

    #if postst.user != current_user
    #  if postst.comments.count == 1
    #    Notification.create(recipient: postst.user, actor: current_user, action: "#{posted}", notifiable: commentst)
    #  end
    #end

  end
end

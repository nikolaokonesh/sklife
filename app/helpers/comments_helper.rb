module CommentsHelper
  def reply_to_comment_id(comment, nesting, max_nesting)
    # Use the comment as the parent if we allow unlimited nesting
    # or if it's inside the allowed nesting
    if max_nesting.blank? || nesting < max_nesting
      comment.id
    else
      # Otherwise, we want to use the comment's parent,
      # and just nest the new comment as a sibling
      comment.parent_id
    end
  end

  def comment_body_helper(comment)
    if comment.deleted?
      content_tag :div, truncate(strip_tags(comment.body.body.to_s), length: 35, omission: '......'), class: 'line-through text-gray-500'
    else
      content_tag :div, comment.body, class: 'text-gray-700'
    end
  end

  def comment_body_notification_helper(comment)
    if comment.deleted?
      content_tag :div, truncate(strip_tags(comment.body.body.to_s), length: 30, omission: '...'), class: 'line-through text-gray-500'
    else
      truncate(strip_tags(comment.body.body.to_s), length: 30, omission: '...')
    end
  end

  def commentator_url_helper(commentator)
    if commentator.commentable_type == "Article::Post"
      main_app.category_post_url(commentator.commentable.posttable, commentator.commentable, comment: commentator.id, anchor: dom_id(commentator), subdomain: notification_target_helper(commentator.commentable))
    elsif commentator.commentable_type == "Article::Category"
      main_app.category_url(commentator.commentable, comment: commentator.id, anchor: dom_id(commentator), subdomain: notification_target_helper(commentator.commentable))
    else
      main_app.root_url
    end
  end

end

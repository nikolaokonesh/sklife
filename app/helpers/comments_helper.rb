module CommentsHelper
  def reply_to_comment_id(comment, nesting, max_nesting)
    if max_nesting.blank? || nesting < max_nesting
      comment.id
    else
      comment.parent_id
    end
  end

  def comment_body_helper(comment)
    if comment.deleted?
      content_tag :div, truncate(strip_tags(comment.body_comment.body.to_s),
                                 length: 35, omission: '......'), class: 'line-through text-gray-500'
    else
      content_tag :div, comment.body_comment, class: 'text-gray-700'
    end
  end

  def comment_body_notification_helper(comment)
    if comment.deleted?
      content_tag :div, truncate(strip_tags(comment.body_comment.body.to_s),
                                 length: 30, omission: '...'), class: 'line-through text-gray-500'
    else
      truncate(strip_tags(comment.body_comment.body.to_s), length: 30, omission: '...')
    end
  end

  def commentator_url_helper(commentator)
    if commentator.commentable_type == 'Article::Post'
      one_comment_url_service(commentator)
    elsif commentator.commentable_type == 'Article::Category'
      two_comment_url_service(commentator)
    else
      main_app.root_url
    end
  end

  def one_comment_url_service(commentator)
    main_app.category_post_url(
      commentator.commentable.posttable, commentator.commentable,
      comment: commentator.id, anchor: dom_id(commentator),
      subdomain: notification_target_helper(commentator.commentable)
    )
  end

  def two_comment_url_service(commentator)
    main_app.category_url(
      commentator.commentable,
      comment: commentator.id, anchor: dom_id(commentator),
      subdomain: notification_target_helper(commentator.commentable)
    )
  end
end

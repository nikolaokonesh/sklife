class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.user_agent = @user_agent.id if @user_agent.present?
    if @comment.save
      Notifications::CommentJob.perform_later(@commentable, current_user, @comment,
                                              @comment.commentable_type.underscore)
    else
      render partial: 'error', locals: { post: @comment }, status: :bad_request
    end
  end

  def destroy
    if current_user_subscribed?
      @comment = @commentable.comments.find(params[:id])
      @comment.destroy
      redirect_back(fallback_location: @commentable, notice: 'Комментарий успешно удален!')
    else
      redirect_back(fallback_location: @commentable, alert: 'Доступно только для подписчиков!')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body_comment, :parent_id, :user_agent)
  end
end

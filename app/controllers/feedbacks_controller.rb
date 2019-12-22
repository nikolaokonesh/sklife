class FeedbacksController < ApplicationController
  before_action :authenticate_user!

  def create
    @admin = User.where(admin: true).first
    @feedback = current_user.feedbacks.new(feedback_params)
    if @feedback.save
      Notification.create(user: @admin, actor: current_user,
                          target: @feedback, notify_type: "feedback/feedback")

      # Notifications::FeedbackJob.perform_later(@admin, current_user, @feedback)
    else
      render partial: 'error', feedback: @feedback, status: :bad_request
    end
  end

  private

    def feedback_params
      params.require(:feedback).permit(:email, :phone, :message)
    end

end


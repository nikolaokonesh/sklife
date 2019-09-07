class FeedbacksController < ApplicationController
  before_action :authenticate_user!

  def create
    @feedback = current_user.feedbacks.new(feedback_params)
    if @feedback.save
    else
      render partial: 'error', feedback: @feedback, status: :bad_request
    end
  end

  private

    def feedback_params
      params.require(:feedback).permit(:email, :phone, :message)
    end

end


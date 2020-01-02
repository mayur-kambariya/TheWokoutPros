class Api::V1::FeedbacksController < ApiController
	def create
    user_feedback = current_user.feedbacks.new(feedback_params)
    if user_feedback.save
    	success_response(
        HTTP_OK,
        I18n.t("#{get_controller}.create.feedback_send")
      )
    else
      error_response_without_obj(HTTP_BAD_REQUEST, user_feedback.errors.full_messages.join(', '))
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:content, :user_id)
  end
end

class Api::V1::InvitationsController < ApiController

  def create
  	invitation = current_user.invitations.new(invitation_params)
    if invitation.save
    	UserMailer.with(user: current_user).send_email(invitation).deliver_now
      success_response(
        HTTP_OK, I18n.t("#{get_controller}.create.sent_invitation")
      )
    else
      error_response_without_obj(HTTP_BAD_REQUEST, invitation.errors.full_messages.join(', '))
    end
  end

  private

  def invitation_params
  	params[:invitation][:email] = params[:invitation][:email].present? ? params[:invitation][:email].split(',') : ''
    params.require(:invitation).permit(:message, :user_id, email: [])
  end
end

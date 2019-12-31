class UserMailer < ApplicationMailer

  def send_email(invitation)
    @message = invitation.message
    mail(to: invitation.email, subject: "Invitation Send.", from: invitation.user.email)
  end
end

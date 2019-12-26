# this is the confirmations controller
class Api::V1::ConfirmationsController < ApiController
  skip_before_action :require_login

  def create
    if params[:confirmation_token].present?
      user = User.find_by(confirmation_token: params[:confirmation_token])
      get_user_data(user)
    else
      error_response_without_obj(HTTP_NOT_FOUND, I18n.t("#{get_controller}.create.token_missing"))
    end
  end

  private

  def get_user_data(user)
    if user.present?
      user.confirmed_at = Time.zone.now
      user.confirmation_token = nil
      user.confirmation_sent_at = nil
      user.save(validate: false)
      success_response(HTTP_CREATED, I18n.t("#{get_controller}.create.confirm_success"))
    else
      error_response_without_obj(HTTP_UNAUTHORIZED, I18n.t("#{get_controller}.create.invalid_token"))
    end
  end
end
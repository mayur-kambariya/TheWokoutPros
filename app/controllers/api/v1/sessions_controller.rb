# this is the sessions controller
class Api::V1::SessionsController < ApiController
  skip_before_action :require_login, only: :create

  def create
    user = User.find_by(email: params[:user][:email])
    if user.present?
      if user.valid_password?(params[:user][:password])
        user_confirm_check(user)
      else
        error_response_without_obj(
          HTTP_BAD_REQUEST,
          I18n.t("#{get_controller}.create.password_invalid")
        )
      end
    else
      error_response_without_obj(
        HTTP_NOT_FOUND,
        I18n.t("#{get_controller}.create.email_not_found")
      )
    end
  end

  def destroy
    auth_token = AuthToken.find_by(auth_token: params[:auth_token])
    if auth_token.present?
      auth_token.destroy
      success_response(
        HTTP_OK, I18n.t("#{get_controller}.destroy.logout_success"))
    else
      error_response_without_obj(HTTP_UNAUTHORIZED, I18n.t("#{get_controller}.destroy.fail_to_logout"))
    end
  end

  private

  def user_confirm_check(user)
    if user.confirmed?
      token = user.generate_auth_token
      login_user = UserSerializer.new(user).serializable_hash[:data][:attributes].merge!({auth_token: token})
      success_response_with_object(login_user,
        I18n.t("#{get_controller}.create.login_success"))
    else
      error_response_without_obj(HTTP_BAD_REQUEST, I18n.t("#{get_controller}.create.fail_to_login"))
    end
  end
end
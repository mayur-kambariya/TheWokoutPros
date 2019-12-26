# this is the passwords controller
class Api::V1::PasswordsController < ApiController
  before_action :require_login, only: :change_password

  def change_password
    if current_user.present? &&
      current_user.valid_password?(params[:user][:password])
      user_password_check(params[:user][:new_password])
    else
      error_response_without_obj(
        HTTP_UNAUTHORIZED,
        I18n.t('controllers.api.v1.passwords_controller.change_password.invalid_password')
      )
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user.present?
      set_user_password(user)
    else
      error_response_without_obj(
        HTTP_NOT_FOUND,
        I18n.t('controllers.api.v1.passwords_controller.create.email_not_found')
      )
    end
  end

  def reset_password
    user = User.find_by(reset_password_token: params[:reset_password_token])
    if user.present?
      new_password_check(user, params[:user][:new_password])
    else
      error_response_without_obj(
        HTTP_NOT_FOUND,
        I18n.t('controllers.api.v1.passwords_controller.reset_password.fail_to_reset')
      )
    end
  end

  private

  def user_password_check(get_user_new_password)
    if get_user_new_password.match(/\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}\z/)
      user_update_attribute(get_user_new_password)
    else
      error_response_without_obj(
        HTTP_BAD_REQUEST,
        I18n.t('controllers.api.v1.passwords_controller.change_password.password_validation_msg')
      )
    end
  end

  def user_update_attribute(user_new_password)
    if current_user.update_attribute('password', user_new_password)
      success_response(
        HTTP_CREATED,
        I18n.t('controllers.api.v1.passwords_controller.change_password.password_updated')
      )
    else
      error_response_without_obj(
        HTTP_BAD_REQUEST,
        I18n.t('controllers.api.v1.passwords_controller.change_password.fail_to_update')
      )
    end
  end

  def set_user_password(user)
    if user.deliver_password_reset_instructions
      success_response(
        HTTP_CREATED, I18n.t('controllers.api.v1.passwords_controller.create.password_reset')
      )
    else
      error_response_without_obj(
        HTTP_BAD_REQUEST, I18n.t('controllers.api.v1.passwords_controller.create.fail_to_send')
      )
    end
  end

  def new_password_check(user, get_password)
    if get_password.match(/\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}\z/)
      user_reset_password(user, get_password)
    else
      error_response_without_obj(
        HTTP_BAD_REQUEST,
        I18n.t('controllers.api.v1.passwords_controller.reset_password.validation_msg')
      )
    end
  end

  def user_reset_password(user, new_password)
    if user.update_attribute('password', new_password)
      success_response(
        HTTP_CREATED,
        I18n.t('controllers.api.v1.passwords_controller.reset_password.success')
      )
    else
      error_response_without_obj(
        HTTP_BAD_REQUEST,
        I18n.t('controllers.api.v1.passwords_controller.reset_password.fail_to_reset')
      )
    end
  end
end
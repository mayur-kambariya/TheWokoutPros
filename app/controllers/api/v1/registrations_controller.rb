# this is the registrations controller
class Api::V1::RegistrationsController < ApiController
  skip_before_action :require_login

  def create
    user = User.new(user_params)
    if user.save
      user_info = UserSerializer.new(user).serializable_hash[:data][:attributes]
      success_response_with_message(
        user_info,
        I18n.t("#{get_controller}.create.register_succes")
      )
    else
      error_response_without_obj(HTTP_BAD_REQUEST, I18n.t("#{get_controller}.create.fail_to_register"))
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
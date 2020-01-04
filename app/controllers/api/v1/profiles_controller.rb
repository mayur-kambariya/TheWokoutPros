class Api::V1::ProfilesController < ApiController

  def get_profile
    if current_user.profile.present?
      user_profile = ProfileSerializer.new(current_user.profile)
      success_response_with_object(user_profile.serializable_hash[:data][:attributes],
        "Ok")
    else
      error_response_without_obj(
        HTTP_NOT_FOUND,
        I18n.t("#{get_controller}.show.profile_not_found")
      )
    end
  end

  def update_profile
    if current_user.profile.present?
      user_profile_update(current_user.profile)
    else
      error_response_without_obj(
        HTTP_NOT_FOUND,
        I18n.t("#{get_controller}.update.profile_not_found")
      )
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :display_name, :location,
      :about_you, :user_id
    )
  end

  def user_profile_update(user_profile)
    if user_profile.update(profile_params)
      if params[:profile][:profile_picture].present?
        user_profile.profile_picture.attach(params[:profile][:profile_picture])
      end
      if params[:profile][:aditional_pictures].present?
        user_profile.aditional_pictures.attach(params[:profile][:aditional_pictures])
      end
      my_profile_info = ProfileSerializer.new(user_profile).serializable_hash[:data][:attributes]
      success_response_with_message(
        my_profile_info,
        I18n.t("#{get_controller}.update.update_success")
      )
    else
      error_response_without_obj(
        HTTP_BAD_REQUEST,
        @profile.errors.full_messages.join(', ')
      )
    end
  end
end

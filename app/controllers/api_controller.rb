# this is api controller
class ApiController < ApplicationController
  include ApplicationHelper
  before_action :require_login

  def require_login
    if !params[:auth_token].nil?
      auth_token = AuthToken.find_by(auth_token: params[:auth_token])
      if auth_token.present?
        @current_user = auth_token.user
        true
      else
        error_response_without_obj(HTTP_UNAUTHORIZED, I18n.t("#{get_controller}.require_login.unable_to_authenticate"))
      end
    else
      error_response_without_obj(HTTP_UNAUTHORIZED, I18n.t("#{get_controller}.require_login.token_is_missing"))
    end
  end

  def current_user
    @current_user
  end

  def get_controller
    "controllers.api.v1.#{self.controller_name}_controller"
  end

end
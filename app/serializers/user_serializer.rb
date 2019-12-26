class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email
  attributes :auth_token do |user, params|
    params[:auth_token].present? ? params[:auth_token] : ''
  end
end

require 'test_helper'

class Api::V1ControllerTest < ActionDispatch::IntegrationTest
  test "should get profiles" do
    get api_v1_profiles_url
    assert_response :success
  end

end

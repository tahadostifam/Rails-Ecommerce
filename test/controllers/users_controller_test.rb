require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get users_login_url
    assert_response :success
  end

  test "should get register" do
    get users_register_url
    assert_response :success
  end

  test "should get authenticate" do
    get users_authenticate_url
    assert_response :success
  end
end

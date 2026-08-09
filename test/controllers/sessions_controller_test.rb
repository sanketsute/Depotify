require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_url
    assert_response :success
  end

  test "should create a session" do
    post login_url, params: { name: users(:one).name, password: "secret" }
    assert_redirected_to store_index_url
  end

  test "should destroy session" do
    get logout_url
    assert_redirected_to store_index_url
  end
end

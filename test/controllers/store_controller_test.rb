require "test_helper"

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
    assert_select "h1", "The Pragmatic Collection"
    assert_select "li a", minimum: 7
  end
end

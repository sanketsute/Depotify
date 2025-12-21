require "test_helper"

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_item = line_items(:one)
  end

  test "should_create_line_item" do
    assert_difference("LineItem.count") do
      post line_items_url, params: {product_id: products(:one).id }
    end
    follow_redirect!
    assert_select "h1", "Your Cart"
  end
end

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
  end

  test "should_create_line_item_via_turbo_stream" do
    assert_difference("LineItem.count") do
      post line_items_url, params: { product_id: products(:one).id }, as: :turbo_stream
    end
    assert_response :success
  end

  test "should_update_line_item_via_turbo_stream_and_increase_quantity_by_1" do
    assert_difference("@line_item.reload.quantity", 1) do
       patch line_item_url(@line_item), params: { line_item: { quantity: @line_item.quantity + 1 }, turbo_stream: "true" }, as: :turbo_stream
    end
    assert_response :success
    
  end

    test "should_destroy_line_item_via_turbo_stream" do
    delete line_item_url(@line_item), params: { turbo_stream: "true" }, as: :turbo_stream
    assert_response :success
  end

end

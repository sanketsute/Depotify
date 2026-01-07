require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart = carts(:one)
  end

  test "should get index" do
    get carts_url
    assert_response :success
  end

  test "should get new" do
    get new_cart_url
    assert_response :success
  end

  test "should create cart" do
    assert_difference("Cart.count") do
      post carts_url, params: { cart: {} }
    end

    assert_redirected_to cart_url(Cart.last)
  end

  test "should redirect to store index" do
    get cart_url(@cart)
    assert_response :redirect
    assert_redirected_to store_index_url
  end

   test "should show cart" do
    post line_items_url(product_id: products(:one).id)
    @cart = Cart.find(session[:cart_id])
    get cart_url(@cart)
    assert_response :success
  end

  test "should get edit" do
    get edit_cart_url(@cart)
    assert_response :success
  end

  test "should update cart" do
    patch cart_url(@cart), params: { cart: {} }
    assert_redirected_to cart_url(@cart)
  end

 test "should destroy cart" do
    post line_items_url(product_id: products(:one).id)
    @cart = Cart.find(session[:cart_id])

    assert_difference("Cart.count", -1) do
      delete cart_url(@cart)
    end

    assert_redirected_to store_index_url
  end

  test "should_have_unique_products_in_cart" do
    post line_items_url, params: { product_id: products(:one).id }
    post line_items_url, params: { product_id: products(:one).id }
    @cart = Cart.find(session[:cart_id])
    assert_equal 1, @cart.line_items.count
    assert_equal 2, @cart.line_items.first.quantity
  end
end

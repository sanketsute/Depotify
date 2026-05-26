require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "check dynamic fields in new order form" do
    visit store_index_url
    click_on "Add to Cart", match: :first
    find("#cart-link").click
    click_on "Proceed to Checkout"

    assert_selector "h1", text: "Please enter your details"

    assert has_no_field? "Routing Number"
    assert has_no_field? "Account Number"
    assert has_no_field? "Check Number"
    assert has_no_field? "Expiration Date"
    assert has_no_field? "Purchase Order Number"

  select "Credit card", from: "Payment Method"
    assert has_field? "Expiration Date"
    assert has_no_field? "Routing Number"
    assert has_no_field? "Account Number"
    assert has_no_field? "Check Number"
    assert has_no_field? "Purchase Order Number"

    select "Check", from: "Payment Method"
    assert has_field? "Routing Number"
    assert has_field? "Account Number"
    assert has_no_field? "Check Number"
    assert has_no_field? "Expiration Date"
    assert has_no_field? "Purchase Order Number"

    select "Purchase order", from: "Payment Method"
    assert has_field? "Purchase Order Number"
    assert has_no_field? "Routing Number"
    assert has_no_field? "Account Number"
    assert has_no_field? "Check Number"
    assert has_no_field? "Expiration Date"
  end

  test "check order and delivery" do
    LineItem.delete_all
    Order.delete_all
    visit store_index_url
    click_on "Add to Cart", match: :first
    find("#cart-link").click
    click_on "Proceed to Checkout"
    fill_in "Name", with: "Dave Thomas"
    fill_in "Address", with: "123 Main Street"
    fill_in "Email", with: "dave@example.com"
    select "Check", from: "Payment Method"
    fill_in "Routing Number", with: "1111"
    fill_in "Account Number", with: "2222"
    click_on "Place Order"
    assert_text "Thank you for your order."
    2.times { perform_enqueued_jobs }
    orders = Order.all
    assert_equal 1, orders.size
    order = orders.first
    assert_equal "Dave Thomas", order.name
    assert_equal "123 Main Street", order.address
    assert_equal "dave@example.com", order.email
    assert_equal pay_types(:check), order.pay_type
  end
end

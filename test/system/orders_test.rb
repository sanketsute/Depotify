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

end

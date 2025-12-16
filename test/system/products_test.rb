require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test "visiting the index" do
    skip "Temporarily skipped"
    visit products_url
    assert_selector "h1", text: "Products"
  end

  test "should create product" do
    skip "Temporarily skipped"
    visit products_url
    click_on "New product"

    fill_in "Description", with: @product.description
    fill_in "Image", with: @product.image
    fill_in "Title", with: @product.title
    click_on "Create Product"

    assert_text "Product was successfully created"
    click_on "Back"
  end

  test "should update Product" do
    skip "Temporarily skipped"
    visit product_url(@product)
    click_on "Edit this product", match: :first

    fill_in "Description", with: @product.description
    fill_in "Image", with: @product.image_u
    fill_in "Title", with: @product.title
    click_on "Update Product"

    assert_text "Product was successfully updated"
    click_on "Back"
  end

  test "should destroy Product" do
    skip "Temporarily skipped"
    visit product_url(@product)
    click_on "Delete", match: :first

    assert_text "Product was successfully destroyed"
  end
end

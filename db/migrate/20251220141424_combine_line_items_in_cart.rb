class CombineLineItemsInCart < ActiveRecord::Migration[8.0]
  def up
   Cart.find_each do |cart|
      products_sum = cart.line_items.group(:product_id).sum(:quantity)
      products_sum.each do |product_id, sum_quantity|
        ActiveRecord::Base.transaction do
         cart.line_items.where(product_id: product_id).destroy_all
         cart.line_items.create(product_id: product_id, quantity: sum_quantity)
         end
      end
    end
  end
  def down
     LineItem.where("quantity > 1").find_each do |line_item|
      ActiveRecord::Base.transaction do
        (line_item.quantity - 1).times do
          LineItem.create!(
            cart_id: line_item.cart_id,
            product_id: line_item.product_id,
            quantity: 1
          )
        end
        line_item.update!(quantity: 1)
      end
    end
  end
end

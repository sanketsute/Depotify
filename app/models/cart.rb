class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy


  def total_price
    line_items.sum { |item| item.total_price }
  end

  def total_items
    line_items.sum(:quantity)
  end


  def add_product(product_id)
    current_item = line_items.find_by(product_id: product_id)
    if current_item.present?
      current_item.quantity+=1
    else
      current_item = line_items.build(product_id: product_id)
    end
    current_item
  end
end

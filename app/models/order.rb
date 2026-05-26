require "pago"

class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :pay_type

  validates :name, :address, :email, :pay_type_id, presence: true

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def total_price
    line_items.sum { |item| item.total_price }
  end

  def charge!(pay_type_params, pay_type)
    payment_details = {}
    payment_method = pay_type.code.to_sym

    case payment_method
    when :check
      payment_details[:routing] = pay_type_params.fetch(:routing_number)
      payment_details[:account] = pay_type_params.fetch(:account_number)
    when :credit_card
      payment_details[:cc_num] = pay_type_params.fetch(:credit_card_number)
      payment_details[:expiration_month] = pay_type_params.fetch(:expiration_date).month
      payment_details[:expiration_year] = pay_type_params.fetch(:expiration_date).year
    when :purchase_order
      payment_details[:po_num] = pay_type_params.fetch(:po_number)
    end

    payment_result = Pago.make_payment(order_id: id, payment_method: payment_method, payment_details: payment_details)

    if payment_result.succeeded?
      OrderMailer.received(self).deliver_later
    else
      raise "Payment failed"
    end
  end
end

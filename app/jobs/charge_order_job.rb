class ChargeOrderJob < ApplicationJob
  queue_as :default

  def perform(order, pay_type_params, pay_type)
    order.charge!(pay_type_params, pay_type)
  end
end

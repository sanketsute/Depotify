class OrderMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.received.subject
  #
  default from: "sankettestsute@gmail.com"
  def received(order)
    @order = order

    mail to: order.email, subject: "The Pragmatic Order Confirmation" do |format|
      format.html
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped(order)
    @order = order

    mail to: order.email, subject: "The Pragmatic Order Shipped" do |format|
      format.html
    end
  end
end

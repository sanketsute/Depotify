require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:one))
    assert_equal "The Pragmatic Order Confirmation", mail.subject
    assert_equal [ "sankettestsute@gmail.com" ], mail.to
    assert_equal [ "sankettestsute@gmail.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:one))
    assert_equal "The Pragmatic Order Shipped", mail.subject
    assert_equal [ "sankettestsute@gmail.com" ], mail.to
    assert_equal [ "sankettestsute@gmail.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end

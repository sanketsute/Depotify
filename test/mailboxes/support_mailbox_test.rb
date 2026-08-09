require "test_helper"

class SupportMailboxTest < ActionMailbox::TestCase
  # test "receive mail" do
  #   receive_inbound_email_from_mail \
  #     to: '"someone" <someone@example.com>',
  #     from: '"else" <else@example.com>',
  #     subject: "Hello world!",
  #     body: "Hello?"
  # end
  # 
  test "we create a submit request when we get a support email" do
    receive_inbound_email_from_mail(
      to: "support@example.com",
      from: 'sankettestsute@gmail.com',
      subject: "Hello world!",
      body: "Hello?"
    )
    support_request = SupportRequest.last
    assert_equal "Hello?", support_request.body
    assert_equal "Hello world!", support_request.subject
    assert_equal "sankettestsute@gmail.com", support_request.email
    assert_equal orders(:one), support_request.order
  end
end

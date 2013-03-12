require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "newapp_notice" do
    mail = UserMailer.newapp_notice
    assert_equal "Newapp notice", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

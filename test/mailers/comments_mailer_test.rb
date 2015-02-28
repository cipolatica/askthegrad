require 'test_helper'

class CommentsMailerTest < ActionMailer::TestCase
  test "parent_comment" do
    mail = CommentsMailer.parent_comment
    assert_equal "Parent comment", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

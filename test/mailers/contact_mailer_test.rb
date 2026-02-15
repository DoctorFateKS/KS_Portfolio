require "test_helper"

class ContactMailerTest < ActionMailer::TestCase
  test "submit_contact" do
    mail = ContactMailer.submit_contact
    assert_equal "Submit contact", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end

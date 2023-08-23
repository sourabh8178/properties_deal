require "test_helper"

class MessageControllerTest < ActionDispatch::IntegrationTest
  test "should get _message" do
    get message__message_url
    assert_response :success
  end

  test "should get _new_message_form.html.erb" do
    get message__new_message_form.html.erb_url
    assert_response :success
  end
end

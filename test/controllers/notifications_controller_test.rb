require "test_helper"

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get _notification" do
    get notifications__notification_url
    assert_response :success
  end
end

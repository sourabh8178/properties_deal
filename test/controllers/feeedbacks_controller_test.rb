require "test_helper"

class FeeedbacksControllerTest < ActionDispatch::IntegrationTest
  test "should get _feedback" do
    get feeedbacks__feedback_url
    assert_response :success
  end
end

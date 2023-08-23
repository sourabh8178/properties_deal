require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rooms_index_url
    assert_response :success
  end

  test "should get _index" do
    get rooms__index_url
    assert_response :success
  end
end

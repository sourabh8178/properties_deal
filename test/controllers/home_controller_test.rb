require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "should get grad" do
    get home_grad_url
    assert_response :success
  end

  test "should get show" do
    get home_show_url
    assert_response :success
  end

  test "should get view_all_property" do
    get home_view_all_property_url
    assert_response :success
  end

  test "should get property_view" do
    get home_property_view_url
    assert_response :success
  end

  test "should get _search" do
    get home__search_url
    assert_response :success
  end

  test "should get _property_search" do
    get home__property_search_url
    assert_response :success
  end
end

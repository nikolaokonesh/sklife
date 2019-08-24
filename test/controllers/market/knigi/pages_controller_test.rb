require 'test_helper'

class Market::Knigi::PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @market_knigi_page = market_knigi_pages(:one)
  end

  test "should get index" do
    get market_knigi_pages_url
    assert_response :success
  end

  test "should get new" do
    get new_market_knigi_page_url
    assert_response :success
  end

  test "should create market_knigi_page" do
    assert_difference('Market::Knigi::Page.count') do
      post market_knigi_pages_url, params: { market_knigi_page: { commentable_id: @market_knigi_page.commentable_id, commentable_type: @market_knigi_page.commentable_type, title: @market_knigi_page.title } }
    end

    assert_redirected_to market_knigi_page_url(Market::Knigi::Page.last)
  end

  test "should show market_knigi_page" do
    get market_knigi_page_url(@market_knigi_page)
    assert_response :success
  end

  test "should get edit" do
    get edit_market_knigi_page_url(@market_knigi_page)
    assert_response :success
  end

  test "should update market_knigi_page" do
    patch market_knigi_page_url(@market_knigi_page), params: { market_knigi_page: { commentable_id: @market_knigi_page.commentable_id, commentable_type: @market_knigi_page.commentable_type, title: @market_knigi_page.title } }
    assert_redirected_to market_knigi_page_url(@market_knigi_page)
  end

  test "should destroy market_knigi_page" do
    assert_difference('Market::Knigi::Page.count', -1) do
      delete market_knigi_page_url(@market_knigi_page)
    end

    assert_redirected_to market_knigi_pages_url
  end
end

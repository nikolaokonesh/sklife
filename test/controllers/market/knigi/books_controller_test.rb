require 'test_helper'

class Market::Knigi::BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @market_knigi_book = market_knigi_books(:one)
  end

  test "should get index" do
    get market_knigi_books_url
    assert_response :success
  end

  test "should get new" do
    get new_market_knigi_book_url
    assert_response :success
  end

  test "should create market_knigi_book" do
    assert_difference('Market::Knigi::Book.count') do
      post market_knigi_books_url, params: { market_knigi_book: { author: @market_knigi_book.author, data: @market_knigi_book.data, price: @market_knigi_book.price, public: @market_knigi_book.public, slug: @market_knigi_book.slug, title: @market_knigi_book.title, user_id: @market_knigi_book.user_id } }
    end

    assert_redirected_to market_knigi_book_url(Market::Knigi::Book.last)
  end

  test "should show market_knigi_book" do
    get market_knigi_book_url(@market_knigi_book)
    assert_response :success
  end

  test "should get edit" do
    get edit_market_knigi_book_url(@market_knigi_book)
    assert_response :success
  end

  test "should update market_knigi_book" do
    patch market_knigi_book_url(@market_knigi_book), params: { market_knigi_book: { author: @market_knigi_book.author, data: @market_knigi_book.data, price: @market_knigi_book.price, public: @market_knigi_book.public, slug: @market_knigi_book.slug, title: @market_knigi_book.title, user_id: @market_knigi_book.user_id } }
    assert_redirected_to market_knigi_book_url(@market_knigi_book)
  end

  test "should destroy market_knigi_book" do
    assert_difference('Market::Knigi::Book.count', -1) do
      delete market_knigi_book_url(@market_knigi_book)
    end

    assert_redirected_to market_knigi_books_url
  end
end

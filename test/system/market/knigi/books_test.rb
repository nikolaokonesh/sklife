require "application_system_test_case"

class Market::Knigi::BooksTest < ApplicationSystemTestCase
  setup do
    @market_knigi_book = market_knigi_books(:one)
  end

  test "visiting the index" do
    visit market_knigi_books_url
    assert_selector "h1", text: "Market/Knigi/Books"
  end

  test "creating a Book" do
    visit market_knigi_books_url
    click_on "New Market/Knigi/Book"

    fill_in "Author", with: @market_knigi_book.author
    fill_in "Data", with: @market_knigi_book.data
    fill_in "Price", with: @market_knigi_book.price
    check "Public" if @market_knigi_book.public
    fill_in "Slug", with: @market_knigi_book.slug
    fill_in "Title", with: @market_knigi_book.title
    fill_in "User", with: @market_knigi_book.user_id
    click_on "Create Book"

    assert_text "Book was successfully created"
    click_on "Back"
  end

  test "updating a Book" do
    visit market_knigi_books_url
    click_on "Edit", match: :first

    fill_in "Author", with: @market_knigi_book.author
    fill_in "Data", with: @market_knigi_book.data
    fill_in "Price", with: @market_knigi_book.price
    check "Public" if @market_knigi_book.public
    fill_in "Slug", with: @market_knigi_book.slug
    fill_in "Title", with: @market_knigi_book.title
    fill_in "User", with: @market_knigi_book.user_id
    click_on "Update Book"

    assert_text "Book was successfully updated"
    click_on "Back"
  end

  test "destroying a Book" do
    visit market_knigi_books_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Book was successfully destroyed"
  end
end

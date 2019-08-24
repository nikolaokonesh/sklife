require "application_system_test_case"

class Market::Knigi::PagesTest < ApplicationSystemTestCase
  setup do
    @market_knigi_page = market_knigi_pages(:one)
  end

  test "visiting the index" do
    visit market_knigi_pages_url
    assert_selector "h1", text: "Market/Knigi/Pages"
  end

  test "creating a Page" do
    visit market_knigi_pages_url
    click_on "New Market/Knigi/Page"

    fill_in "Commentable", with: @market_knigi_page.commentable_id
    fill_in "Commentable type", with: @market_knigi_page.commentable_type
    fill_in "Title", with: @market_knigi_page.title
    click_on "Create Page"

    assert_text "Page was successfully created"
    click_on "Back"
  end

  test "updating a Page" do
    visit market_knigi_pages_url
    click_on "Edit", match: :first

    fill_in "Commentable", with: @market_knigi_page.commentable_id
    fill_in "Commentable type", with: @market_knigi_page.commentable_type
    fill_in "Title", with: @market_knigi_page.title
    click_on "Update Page"

    assert_text "Page was successfully updated"
    click_on "Back"
  end

  test "destroying a Page" do
    visit market_knigi_pages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Page was successfully destroyed"
  end
end

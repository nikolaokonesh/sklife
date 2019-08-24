require "application_system_test_case"

class Article::CategoriesTest < ApplicationSystemTestCase
  setup do
    @article_category = article_categories(:one)
  end

  test "visiting the index" do
    visit article_categories_url
    assert_selector "h1", text: "Article/Categories"
  end

  test "creating a Category" do
    visit article_categories_url
    click_on "New Article/Category"

    check "No comments" if @article_category.no_comments
    check "No data" if @article_category.no_data
    fill_in "Slug", with: @article_category.slug
    fill_in "Title", with: @article_category.title
    fill_in "Type", with: @article_category.type
    fill_in "Upgrade", with: @article_category.upgrade
    fill_in "User", with: @article_category.user_id
    click_on "Create Category"

    assert_text "Category was successfully created"
    click_on "Back"
  end

  test "updating a Category" do
    visit article_categories_url
    click_on "Edit", match: :first

    check "No comments" if @article_category.no_comments
    check "No data" if @article_category.no_data
    fill_in "Slug", with: @article_category.slug
    fill_in "Title", with: @article_category.title
    fill_in "Type", with: @article_category.type
    fill_in "Upgrade", with: @article_category.upgrade
    fill_in "User", with: @article_category.user_id
    click_on "Update Category"

    assert_text "Category was successfully updated"
    click_on "Back"
  end

  test "destroying a Category" do
    visit article_categories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Category was successfully destroyed"
  end
end

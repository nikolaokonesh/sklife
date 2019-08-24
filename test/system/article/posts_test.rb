require "application_system_test_case"

class Article::PostsTest < ApplicationSystemTestCase
  setup do
    @article_post = article_posts(:one)
  end

  test "visiting the index" do
    visit article_posts_url
    assert_selector "h1", text: "Article/Posts"
  end

  test "creating a Post" do
    visit article_posts_url
    click_on "New Article/Post"

    check "No comments" if @article_post.no_comments
    fill_in "Posttable", with: @article_post.posttable_id
    fill_in "Posttable type", with: @article_post.posttable_type
    fill_in "Slug", with: @article_post.slug
    check "Subscribe" if @article_post.subscribe
    fill_in "Title", with: @article_post.title
    fill_in "Type", with: @article_post.type
    fill_in "Upgrade", with: @article_post.upgrade
    fill_in "User", with: @article_post.user_id
    click_on "Create Post"

    assert_text "Post was successfully created"
    click_on "Back"
  end

  test "updating a Post" do
    visit article_posts_url
    click_on "Edit", match: :first

    check "No comments" if @article_post.no_comments
    fill_in "Posttable", with: @article_post.posttable_id
    fill_in "Posttable type", with: @article_post.posttable_type
    fill_in "Slug", with: @article_post.slug
    check "Subscribe" if @article_post.subscribe
    fill_in "Title", with: @article_post.title
    fill_in "Type", with: @article_post.type
    fill_in "Upgrade", with: @article_post.upgrade
    fill_in "User", with: @article_post.user_id
    click_on "Update Post"

    assert_text "Post was successfully updated"
    click_on "Back"
  end

  test "destroying a Post" do
    visit article_posts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Post was successfully destroyed"
  end
end

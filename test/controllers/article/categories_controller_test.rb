require 'test_helper'

class Article::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article_category = article_categories(:one)
  end

  test "should get index" do
    get article_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_article_category_url
    assert_response :success
  end

  test "should create article_category" do
    assert_difference('Article::Category.count') do
      post article_categories_url, params: { article_category: { no_comments: @article_category.no_comments, no_data: @article_category.no_data, slug: @article_category.slug, title: @article_category.title, type: @article_category.type, upgrade: @article_category.upgrade, user_id: @article_category.user_id } }
    end

    assert_redirected_to article_category_url(Article::Category.last)
  end

  test "should show article_category" do
    get article_category_url(@article_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_category_url(@article_category)
    assert_response :success
  end

  test "should update article_category" do
    patch article_category_url(@article_category), params: { article_category: { no_comments: @article_category.no_comments, no_data: @article_category.no_data, slug: @article_category.slug, title: @article_category.title, type: @article_category.type, upgrade: @article_category.upgrade, user_id: @article_category.user_id } }
    assert_redirected_to article_category_url(@article_category)
  end

  test "should destroy article_category" do
    assert_difference('Article::Category.count', -1) do
      delete article_category_url(@article_category)
    end

    assert_redirected_to article_categories_url
  end
end

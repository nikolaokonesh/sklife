require 'test_helper'

class Article::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article_post = article_posts(:one)
  end

  test "should get index" do
    get article_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_article_post_url
    assert_response :success
  end

  test "should create article_post" do
    assert_difference('Article::Post.count') do
      post article_posts_url, params: { article_post: { no_comments: @article_post.no_comments, posttable_id: @article_post.posttable_id, posttable_type: @article_post.posttable_type, slug: @article_post.slug, subscribe: @article_post.subscribe, title: @article_post.title, type: @article_post.type, upgrade: @article_post.upgrade, user_id: @article_post.user_id } }
    end

    assert_redirected_to article_post_url(Article::Post.last)
  end

  test "should show article_post" do
    get article_post_url(@article_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_post_url(@article_post)
    assert_response :success
  end

  test "should update article_post" do
    patch article_post_url(@article_post), params: { article_post: { no_comments: @article_post.no_comments, posttable_id: @article_post.posttable_id, posttable_type: @article_post.posttable_type, slug: @article_post.slug, subscribe: @article_post.subscribe, title: @article_post.title, type: @article_post.type, upgrade: @article_post.upgrade, user_id: @article_post.user_id } }
    assert_redirected_to article_post_url(@article_post)
  end

  test "should destroy article_post" do
    assert_difference('Article::Post.count', -1) do
      delete article_post_url(@article_post)
    end

    assert_redirected_to article_posts_url
  end
end

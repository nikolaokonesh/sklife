class AddNoDataToArticlePosts < ActiveRecord::Migration[6.0]
  def change
    add_column :article_posts, :no_data, :boolean
  end
end

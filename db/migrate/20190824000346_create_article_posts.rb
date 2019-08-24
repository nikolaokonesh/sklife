class CreateArticlePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :article_posts do |t|
      t.string :title
      t.integer :posttable_id
      t.string :posttable_type
      t.boolean :no_comments
      t.boolean :subscribe
      t.datetime :upgrade
      t.references :user, null: false, foreign_key: true
      t.string :type
      t.string :slug

      t.timestamps
    end
    add_index :article_posts, :slug, unique: true
  end
end

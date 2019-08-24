class CreateArticleCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :article_categories do |t|
      t.string :title
      t.boolean :no_data
      t.boolean :no_comments
      t.datetime :upgrade
      t.references :user, null: false, foreign_key: true
      t.string :type
      t.string :slug

      t.timestamps
    end
    add_index :article_categories, :slug, unique: true
  end
end

class CreateMarketKnigiBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :market_knigi_books do |t|
      t.string :title
      t.string :author
      t.references :user, null: false, foreign_key: true
      t.string :slug
      t.decimal :price
      t.date :data
      t.boolean :public

      t.timestamps
    end
    add_index :market_knigi_books, :slug, unique: true
  end
end

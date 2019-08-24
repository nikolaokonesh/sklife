class CreateMarketKnigiPages < ActiveRecord::Migration[6.0]
  def change
    create_table :market_knigi_pages do |t|
      t.string :title
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps
    end
  end
end

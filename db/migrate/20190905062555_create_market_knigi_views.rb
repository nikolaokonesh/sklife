class CreateMarketKnigiViews < ActiveRecord::Migration[6.0]
  def change
    create_table :market_knigi_views do |t|
      t.integer :page_id
      t.integer :user_id

      t.timestamps
    end
  end
end

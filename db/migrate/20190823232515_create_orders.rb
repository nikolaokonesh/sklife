class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :number
      t.string :about
      t.string :price
      t.references :user, null: false, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end

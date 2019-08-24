class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :bio
      t.string :org
      t.string :prof
      t.string :email
      t.string :phone
      t.string :bgcolor

      t.timestamps
    end
  end
end

class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :commentable, polymorphic: true
      t.integer :parent_id
      t.integer :user_agent

      t.timestamps
    end
  end
end

class ChangeComments < ActiveRecord::Migration[7.0]

  def change
    create_table :comments do |t|
      t.text :body
      t.references :post, null: false, foreign_key: true
      t.references :parent, foreign_key: { to_table: :comments }
      t.timestamps
    end
  end
end

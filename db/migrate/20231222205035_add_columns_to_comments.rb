class AddColumnsToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :body, :text
    add_reference :comments, :user, foreign_key: true
    add_reference :comments, :post, null: true, foreign_key: true
    add_reference :comments, :parent, null: true, foreign_key: { to_table: :comments }
  end
end

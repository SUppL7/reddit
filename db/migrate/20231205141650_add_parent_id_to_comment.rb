  class AddParentIdToComment < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :parent_id, :integer
    add_column :comments, :post_id, :integer
  end
end

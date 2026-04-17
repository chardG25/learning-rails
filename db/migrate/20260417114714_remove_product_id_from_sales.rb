class RemoveProductIdFromSales < ActiveRecord::Migration[8.1]
  def change
    remove_column :sales, :product_id, :string
  end
end

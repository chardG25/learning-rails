class CreateSales < ActiveRecord::Migration[8.1]
  def change
    create_table :sales do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, default: 1
      t.decimal :total_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end

class DropCartTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :carts
    add_column :cart_items, :customer_id, :bigint
  end
end

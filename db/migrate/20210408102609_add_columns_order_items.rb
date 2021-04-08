class AddColumnsOrderItems < ActiveRecord::Migration[6.1]
  def change
    add_column :order_items, :quantity, :integer
    add_column :order_items, :subtotal, :integer
    remove_column :orders, :quantity
    remove_column :orders, :item_id
  end
end

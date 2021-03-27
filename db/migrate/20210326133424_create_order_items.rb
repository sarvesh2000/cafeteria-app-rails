class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.bigint :item_id
      t.bigint :order_id
      t.timestamps
    end
  end
end

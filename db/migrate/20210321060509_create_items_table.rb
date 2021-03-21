class CreateItemsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :available_stock
      t.string :item_name
      t.timestamps
    end
  end
end

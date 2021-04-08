class DropOwnerItems < ActiveRecord::Migration[6.1]
  def change
    drop_table :owner_items
    add_column :items, :cafeteria_owner_id, :bigint
  end
end

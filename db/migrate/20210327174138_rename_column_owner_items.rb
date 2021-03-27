class RenameColumnOwnerItems < ActiveRecord::Migration[6.1]
  def change
    rename_column :owner_items, :owner_id, :cafeteria_owner_id
  end
end

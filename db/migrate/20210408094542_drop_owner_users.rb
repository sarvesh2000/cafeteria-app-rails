class DropOwnerUsers < ActiveRecord::Migration[6.1]
  def change
    drop_table :owner_users
    add_column :cafeteria_users, :cafeteria_owner_id, :bigint
  end
end

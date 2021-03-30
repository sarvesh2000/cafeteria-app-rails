class AddColumnOwnerId < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :owner_id, :bigint
  end
end

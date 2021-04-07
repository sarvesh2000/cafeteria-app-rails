class ChangeColumnNameCart < ActiveRecord::Migration[6.1]
  def change
    rename_column :carts, :user_id, :customer_id

  end
end

class AddColumnPersistanceToken < ActiveRecord::Migration[6.1]
  def change
    add_column :cafeteria_users,:persistence_token, :string,  :null => false
    add_column :cafeteria_owners,:persistence_token, :string,  :null => false
    add_column :customers,:persistence_token, :string,  :null => false
  end
end

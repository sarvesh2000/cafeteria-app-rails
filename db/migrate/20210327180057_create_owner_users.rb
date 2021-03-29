class CreateOwnerUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :owner_users do |t|
      t.bigint :cafeteria_user_id
      t.bigint :cafeteria_owner_id
      t.timestamps
    end
  end
end

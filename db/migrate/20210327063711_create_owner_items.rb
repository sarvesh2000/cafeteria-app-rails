class CreateOwnerItems < ActiveRecord::Migration[6.1]
  def change
    create_table :owner_items do |t|
      t.bigint :owner_id
      t.bigint :item_id
      t.timestamps
    end
  end
end

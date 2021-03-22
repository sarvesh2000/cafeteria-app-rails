class CreateCafeteriaOwners < ActiveRecord::Migration[6.1]
  def change
    create_table :cafeteria_owners do |t|
      t.string :email
      t.string :password_digest
      t.string :cafeteria_name
      t.timestamps
    end
  end
end

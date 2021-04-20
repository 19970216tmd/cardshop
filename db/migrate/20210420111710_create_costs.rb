class CreateCosts < ActiveRecord::Migration[5.2]
  def change
    create_table :costs do |t|
      t.string :user_id
      t.integer :order_id
      t.integer :price
      t.string :out_flug
      t.string :bank_name
      t.string :bank_type
      t.string :bank_number
      t.string :bank_user_name_sei
      t.string :bank_user_name_mei

      t.timestamps
    end
    add_index :costs, :user_id
    add_index :costs, :order_id
  end
end

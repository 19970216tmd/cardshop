class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :order_id
      t.string :user_id
      t.string :card_id
      t.string :buysell_flug
      t.integer :price
      t.string :orderdate
      t.string :out_flug
      t.string :delete_flug
      t.string :out_user_id
      t.string :shipment_flug

      t.timestamps
    end
    add_index :orders, :order_id
    add_index :orders, :user_id
  end
end
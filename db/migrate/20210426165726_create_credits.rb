class CreateCredits < ActiveRecord::Migration[5.2]
  def change
    create_table :credits do |t|
      t.integer :user_id
      t.string :customer_id
      t.string :credit_id

      t.timestamps
    end
    add_index :credits, :user_id
    add_index :credits, :credit_id
  end
end

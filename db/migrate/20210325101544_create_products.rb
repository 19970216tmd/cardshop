class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :card_id
      t.string :card_name
      t.string :category
      t.string :shuuroku

      t.timestamps
    end
  end
end

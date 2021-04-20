class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :user_id
      t.string :postalcode
      t.string :city
      t.string :adress
      t.string :building
      t.string :sei_kana
      t.string :sei_kanzi
      t.string :mei_kana
      t.string :mei_kanzi
      t.string :tel

      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
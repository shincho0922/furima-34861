class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :post_code,       null: false
      t.integer :prefecturse_id, null: false
      t.string :municipalit,     null: false
      t.string :address,         null: false
      t.string :building_name
      t.string :phone_number,    null: false
      t.references :purchase,    foreign_key: true
      t.timestamps
    end
  end
end

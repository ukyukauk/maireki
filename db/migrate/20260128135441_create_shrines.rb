class CreateShrines < ActiveRecord::Migration[7.2]
  def change
    create_table :shrines do |t|
      t.string :name, null: false
      t.string :prefecture, null: false
      t.string :address
      t.text :deities
      t.text :blessings
      t.timestamps
    end
  end
end

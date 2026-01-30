class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.references :visit, null: false
      t.string :name, null: false
      t.integer :category, null: false
      t.integer :price
      t.timestamps
    end
  end
end

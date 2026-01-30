class CreateVisits < ActiveRecord::Migration[7.2]
  def change
    create_table :visits do |t|
      t.references :user, null: false
      t.references :shrine, null: false
      t.date :visited_on, null: false
      t.text :prayer
      t.text :impression
      t.timestamps
    end
  end
end

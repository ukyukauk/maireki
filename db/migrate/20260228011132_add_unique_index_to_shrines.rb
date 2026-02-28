class AddUniqueIndexToShrines < ActiveRecord::Migration[7.2]
  def change
    add_index :shrines, [:user_id, :prefecture, :name], unique: true
  end
end

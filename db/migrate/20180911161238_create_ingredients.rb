class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :serving_size_number
      t.string :serving_size_unit
      
      t.timestamps
    end
  end
end

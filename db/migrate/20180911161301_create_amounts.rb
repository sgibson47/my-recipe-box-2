class CreateAmounts < ActiveRecord::Migration[5.2]
  def change
    create_table :amounts do |t|
      t.belongs_to :ingredient, index: true
      t.belongs_to :recipe, index: true
      t.integer :servings_per_recipe
      
      t.timestamps
    end
  end
end

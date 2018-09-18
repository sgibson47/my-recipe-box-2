class CreateMakings < ActiveRecord::Migration[5.2]
  def change
    create_table :makings do |t|
      t.integer :rating
      t.string :notes
      t.references :user, foreign_key: true
      t.references :recipe, foreign_key: true

      t.timestamps
    end
  end
end

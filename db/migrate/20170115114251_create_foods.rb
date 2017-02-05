class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|

      t.string :name
      t.string :type_of_cuisine
      t.string :type_of_food
      t.string :price_level
      t.string :popularity
      t.string :description
      t.string :location
      t.integer :rating

      t.timestamps null: false
    end
  end
end

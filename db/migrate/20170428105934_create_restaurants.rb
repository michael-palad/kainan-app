class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :telephone_number
      t.string :cusine

      t.timestamps
    end
  end
end

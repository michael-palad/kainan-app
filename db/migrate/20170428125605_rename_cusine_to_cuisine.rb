class RenameCusineToCuisine < ActiveRecord::Migration[5.0]
  def change
    rename_column :restaurants, :cusine, :cuisine
  end
end

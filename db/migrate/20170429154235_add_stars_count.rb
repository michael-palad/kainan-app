class AddStarsCount < ActiveRecord::Migration[5.0]
  def change
     add_column :restaurants, :stars_count, :integer, default: 0
  end
end

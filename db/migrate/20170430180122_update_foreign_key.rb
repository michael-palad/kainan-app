class UpdateForeignKey < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :restaurants, :users
    
    add_foreign_key :restaurants, :users, on_delete: :cascade
  end
end

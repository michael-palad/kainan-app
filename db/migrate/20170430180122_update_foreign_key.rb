class UpdateForeignKey < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :restaurants, :users, on_delete: :cascade
  end
end

class AddCategoryIdToDroit < ActiveRecord::Migration
  def change
    add_column :droits, :category_id, :integer
  end
end

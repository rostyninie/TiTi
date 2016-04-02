class AddCategoryIdToGroupeCategory < ActiveRecord::Migration
  def change
    add_column :groupe_categories, :category_id, :integer
  end
end

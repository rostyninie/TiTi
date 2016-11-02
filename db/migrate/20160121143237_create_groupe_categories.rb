class CreateGroupeCategories < ActiveRecord::Migration
  def change
    create_table :groupe_categories do |t|
      t.integer :groupe_id
      t.integer :category_id

      t.timestamps
    end
  end
end

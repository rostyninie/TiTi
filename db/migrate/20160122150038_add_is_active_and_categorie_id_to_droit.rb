class AddIsActiveAndCategorieIdToDroit < ActiveRecord::Migration
  def change
    add_column :droits, :is_active, :boolean
    add_column :droits, :categorie_id, :integer
  end
end

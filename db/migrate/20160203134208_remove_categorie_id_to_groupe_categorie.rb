class RemoveCategorieIdToGroupeCategorie < ActiveRecord::Migration
  def change
    remove_column :groupe_categories, :categorie_id, :integer
  end
end

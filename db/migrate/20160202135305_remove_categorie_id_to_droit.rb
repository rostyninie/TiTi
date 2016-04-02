class RemoveCategorieIdToDroit < ActiveRecord::Migration
  def change
    remove_column :droits, :categorie_id, :integer
  end
end

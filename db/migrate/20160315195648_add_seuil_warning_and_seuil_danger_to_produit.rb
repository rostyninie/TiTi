class AddSeuilWarningAndSeuilDangerToProduit < ActiveRecord::Migration
  def change
    add_column :produits, :seuil_warning, :integer
    add_column :produits, :seuil_danger, :integer
  end
end

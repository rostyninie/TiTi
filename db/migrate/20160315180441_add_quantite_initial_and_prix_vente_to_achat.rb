class AddQuantiteInitialAndPrixVenteToAchat < ActiveRecord::Migration
  def change
    add_column :achats, :quantite_initial, :integer
    add_column :achats, :prix_vente, :float
  end
end

class AddUniqueProduitIdToCommandeProduit < ActiveRecord::Migration
  def change
    add_reference :commande_produits, :unique_produit, index: true
  end
end

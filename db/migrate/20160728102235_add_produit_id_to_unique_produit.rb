class AddProduitIdToUniqueProduit < ActiveRecord::Migration
  def change
    add_reference :unique_produits, :produit, index: true
  end
end

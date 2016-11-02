class AddAchatIdToCommandeProduit < ActiveRecord::Migration
  def change
    add_reference :commande_produits, :achat, index: true
  end
end

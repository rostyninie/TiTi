class AddRemiseAndQuantiteToCommandeProduit < ActiveRecord::Migration
  def change
    add_column :commande_produits, :remise, :integer
    add_column :commande_produits, :quantite, :integer
  end
end

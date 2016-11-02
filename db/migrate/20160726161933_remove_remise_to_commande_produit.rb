class RemoveRemiseToCommandeProduit < ActiveRecord::Migration
  def change
    remove_column :commande_produits, :remise, :integer
  end
end

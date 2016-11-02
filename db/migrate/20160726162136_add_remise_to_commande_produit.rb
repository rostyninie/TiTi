class AddRemiseToCommandeProduit < ActiveRecord::Migration
  def change
    add_column :commande_produits, :remise, :float
  end
end

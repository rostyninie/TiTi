class AddPuToCommandeProduit < ActiveRecord::Migration
  def change
    add_column :commande_produits, :pu, :float
  end
end

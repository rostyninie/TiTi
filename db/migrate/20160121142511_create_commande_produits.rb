class CreateCommandeProduits < ActiveRecord::Migration
  def change
    create_table :commande_produits do |t|
      t.integer :commande_id
      t.integer :produit_id

      t.timestamps
    end
  end
end

class CreateUniqueProduits < ActiveRecord::Migration
  def change
    create_table :unique_produits do |t|
      t.references :achat_id, index: true
      t.integer :groupe_id
      t.string :code
      t.float :prix_vente
      t.boolean :etat
      t.float :remise

      t.timestamps
    end
  end
end

class CreateProduits < ActiveRecord::Migration
  def change
    create_table :produits do |t|
      t.string :code
      t.string :nom
      t.float :prix_vente
      t.float :prix_gros
      t.integer :quantite_gros
      t.integer :quantite_stock
      t.string :unite
      t.integer :type_produit_id
      t.integer :rayon_id
      t.boolean :is_active

      t.timestamps
    end
  end
end

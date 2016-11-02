class CreateMouvementStocks < ActiveRecord::Migration
  def change
    create_table :mouvement_stocks do |t|
      t.datetime :date
      t.string :type
      t.references :achat, index: true
      t.references :produit, index: true
      t.integer :quantite
      t.float :prix_u

      t.timestamps
    end
  end
end

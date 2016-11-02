class CreateValorisations < ActiveRecord::Migration
  def change
    create_table :valorisations do |t|
      t.string :code
      t.string :type
      t.references :achat, index: true
      t.date :date_debut
      t.date :date_fin
      t.references :produit, index: true

      t.timestamps
    end
  end
end

class CreateFraiAchats < ActiveRecord::Migration
  def change
    create_table :frai_achats do |t|
      t.string :description
      t.float :montant
      t.references :achat, index: true

      t.timestamps
    end
  end
end

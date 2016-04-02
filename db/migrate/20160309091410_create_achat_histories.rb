class CreateAchatHistories < ActiveRecord::Migration
  def change
    create_table :achat_histories do |t|
      t.string :code
      t.float :prix_achat_unitaire
      t.float :marge_brut
      t.float :prix_ht
      t.integer :quantite
      t.date :date_achat
      t.integer :user_id
      t.integer :produit_id

      t.timestamps
    end
  end
end

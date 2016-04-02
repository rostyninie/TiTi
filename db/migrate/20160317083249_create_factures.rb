class CreateFactures < ActiveRecord::Migration
  def change
    create_table :factures do |t|
      t.integer :num
      t.integer :commande_id
      t.integer :client_id
      t.float :montant
      t.boolean :is_solde
      t.date :date_facture

      t.timestamps
    end
  end
end

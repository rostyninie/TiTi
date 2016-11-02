class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :titre
      t.string :description
      t.float :montant
      t.references :achat, index: true
      t.references :commande, index: true
      t.boolean :is_deduc
      t.boolean :is_add
      t.date :date_transaction

      t.timestamps
    end
  end
end

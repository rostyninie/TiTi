class CreateCommandes < ActiveRecord::Migration
  def change
    create_table :commandes do |t|
      t.string :code
      t.float :montant
      t.boolean :en_cour
      t.integer :client_id
      t.date :date_reglage
      t.boolean :is_deleted

      t.timestamps
    end
  end
end

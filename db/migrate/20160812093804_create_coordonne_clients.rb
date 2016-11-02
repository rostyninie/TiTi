class CreateCoordonneClients < ActiveRecord::Migration
  def change
    create_table :coordonne_clients do |t|
      t.references :coordonne_bancaire, index: true
      t.references :client, index: true
      t.string :valeur

      t.timestamps
    end
  end
end

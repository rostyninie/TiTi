class CreateCommandes < ActiveRecord::Migration
  def change
    create_table :commandes do |t|
      t.string :code
      t.boolean :en_cour
      t.integer :client_id
      t.boolean :is_deleted
      t.integer :user_id
      t.timestamps
    end
  end
end

class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :code
      t.string :nom
      t.string :phone
      t.string :address
      t.integer :ville_id
      t.integer :pay_id

      t.timestamps
    end
  end
end

class CreateFournisseurs < ActiveRecord::Migration
  def change
    create_table :fournisseurs do |t|
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

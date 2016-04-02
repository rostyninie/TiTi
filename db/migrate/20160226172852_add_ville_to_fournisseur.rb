class AddVilleToFournisseur < ActiveRecord::Migration
  def change
    add_column :fournisseurs, :ville, :string
  end
end

class RemoveVilleIdToFournisseur < ActiveRecord::Migration
  def change
    remove_column :fournisseurs, :ville_id, :integer
  end
end

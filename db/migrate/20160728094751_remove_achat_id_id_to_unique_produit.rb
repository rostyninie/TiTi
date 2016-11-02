class RemoveAchatIdIdToUniqueProduit < ActiveRecord::Migration
  def change
    remove_column :unique_produits, :achat_id_id, :integer
  end
end

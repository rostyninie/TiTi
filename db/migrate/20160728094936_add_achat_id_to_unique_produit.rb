class AddAchatIdToUniqueProduit < ActiveRecord::Migration
  def change
    add_reference :unique_produits, :achat, index: true
  end
end

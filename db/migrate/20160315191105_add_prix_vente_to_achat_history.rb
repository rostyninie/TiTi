class AddPrixVenteToAchatHistory < ActiveRecord::Migration
  def change
    add_column :achat_histories, :prix_vente, :float
  end
end

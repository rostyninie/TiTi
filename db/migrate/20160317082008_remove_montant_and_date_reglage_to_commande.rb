class RemoveMontantAndDateReglageToCommande < ActiveRecord::Migration
  def change
    remove_column :commandes, :montant, :float
    remove_column :commandes, :date_reglage, :date
  end
end

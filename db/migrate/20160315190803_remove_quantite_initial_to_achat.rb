class RemoveQuantiteInitialToAchat < ActiveRecord::Migration
  def change
    remove_column :achats, :quantite_initial, :integer
  end
end

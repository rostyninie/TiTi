class AddPreviousIdAndNextIdAndIsActiveAndEtatStockToAchat < ActiveRecord::Migration
  def change
    add_column :achats, :previous_id, :integer
    add_column :achats, :next_id, :integer
    add_column :achats, :is_active, :boolean
    add_column :achats, :etat_stock, :integer
  end
end

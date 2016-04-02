class AddVersementToFacture < ActiveRecord::Migration
  def change
    add_column :factures, :versement, :float
  end
end

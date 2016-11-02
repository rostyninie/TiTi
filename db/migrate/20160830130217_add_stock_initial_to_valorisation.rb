class AddStockInitialToValorisation < ActiveRecord::Migration
  def change
    add_column :valorisations, :stock_initial, :integer
  end
end

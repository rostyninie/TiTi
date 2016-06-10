class AddQuantiteStockAvToAchat < ActiveRecord::Migration
  def change
    add_column :achats, :quantite_stock_av, :double
  end
end

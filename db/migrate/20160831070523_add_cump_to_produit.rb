class AddCumpToProduit < ActiveRecord::Migration
  def change
    add_column :produits, :cump, :float
  end
end

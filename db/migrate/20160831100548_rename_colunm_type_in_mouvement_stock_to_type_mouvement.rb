class RenameColunmTypeInMouvementStockToTypeMouvement < ActiveRecord::Migration
  def change
     rename_column :mouvement_stocks, :type, :type_mouvement
  end
end

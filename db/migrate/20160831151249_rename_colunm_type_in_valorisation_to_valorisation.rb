class RenameColunmTypeInValorisationToValorisation < ActiveRecord::Migration
  def change
    rename_column :valorisations, :type, :type_valorisation
  end
end

class AddIsActiveToFournisseur < ActiveRecord::Migration
  def change
    add_column :fournisseurs, :is_active, :boolean
  end
end

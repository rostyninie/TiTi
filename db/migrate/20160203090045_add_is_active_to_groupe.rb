class AddIsActiveToGroupe < ActiveRecord::Migration
  def change
    add_column :groupes, :is_active, :boolean
  end
end

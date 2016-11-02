class AddPrixRevientToAchat < ActiveRecord::Migration
  def change
    add_column :achats, :prix_revient, :float
  end
end

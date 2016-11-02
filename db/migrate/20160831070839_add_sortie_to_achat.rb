class AddSortieToAchat < ActiveRecord::Migration
  def change
    add_column :achats, :sortie, :integer
  end
end

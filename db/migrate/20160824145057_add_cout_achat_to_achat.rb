class AddCoutAchatToAchat < ActiveRecord::Migration
  def change
    add_column :achats, :cout_achat, :float
  end
end

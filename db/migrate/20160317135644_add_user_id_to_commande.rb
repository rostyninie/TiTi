class AddUserIdToCommande < ActiveRecord::Migration
  def change
    add_column :commandes, :user_id, :integer
  end
end

class RemoveVilleIdToClient < ActiveRecord::Migration
  def change
    remove_column :clients, :ville_id, :integer
  end
end

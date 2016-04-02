class AddVilleToClient < ActiveRecord::Migration
  def change
    add_column :clients, :ville, :string
  end
end

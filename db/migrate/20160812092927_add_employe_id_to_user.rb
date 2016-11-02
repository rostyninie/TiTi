class AddEmployeIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :employe_id, :integer
  end
end

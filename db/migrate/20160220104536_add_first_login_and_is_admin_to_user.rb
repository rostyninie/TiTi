class AddFirstLoginAndIsAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_login, :boolean
    add_column :users, :is_admin, :boolean
  end
end

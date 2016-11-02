class AddModeToProduit < ActiveRecord::Migration
  def change
    add_column :produits, :mode, :string
  end
end

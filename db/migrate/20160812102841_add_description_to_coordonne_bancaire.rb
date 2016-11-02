class AddDescriptionToCoordonneBancaire < ActiveRecord::Migration
  def change
    add_column :coordonne_bancaires, :description, :string
  end
end

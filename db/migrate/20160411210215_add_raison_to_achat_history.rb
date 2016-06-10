class AddRaisonToAchatHistory < ActiveRecord::Migration
  def change
    add_column :achat_histories, :raison, :string
  end
end

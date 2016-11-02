class AddCoutAchatToAchatHistory < ActiveRecord::Migration
  def change
    add_column :achat_histories, :cout_achat, :float
  end
end

class CreateCoordonneFournisseurs < ActiveRecord::Migration
  def change
    create_table :coordonne_fournisseurs do |t|
      t.references :coordonne_bancaire, index: true
      t.references :fournisseur, index: true
      t.string :valeur

      t.timestamps
    end
  end
end

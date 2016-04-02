class CreateCategorieDroits < ActiveRecord::Migration
  def change
    create_table :categorie_droits do |t|
      t.integer :categorie_id
      t.integer :droit_id

      t.timestamps
    end
  end
end

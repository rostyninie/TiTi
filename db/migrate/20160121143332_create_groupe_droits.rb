class CreateGroupeDroits < ActiveRecord::Migration
  def change
    create_table :groupe_droits do |t|
      t.integer :groupe_id
      t.integer :droit_id

      t.timestamps
    end
  end
end

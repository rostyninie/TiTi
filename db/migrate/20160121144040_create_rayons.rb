class CreateRayons < ActiveRecord::Migration
  def change
    create_table :rayons do |t|
      t.string :code
      t.string :nom
      t.boolean :is_active

      t.timestamps
    end
  end
end

class CreateCoordonneBancaires < ActiveRecord::Migration
  def change
    create_table :coordonne_bancaires do |t|
      t.string :code
      t.string :nom
      t.boolean :is_active

      t.timestamps
    end
  end
end

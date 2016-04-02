class CreatePays < ActiveRecord::Migration
  def change
    create_table :pays do |t|
      t.string :code
      t.string :nom

      t.timestamps
    end
  end
end

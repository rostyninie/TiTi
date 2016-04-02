class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :code
      t.string :nom
      t.string :description
      t.boolean :is_active

      t.timestamps
    end
  end
end

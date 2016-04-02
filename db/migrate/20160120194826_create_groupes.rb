class CreateGroupes < ActiveRecord::Migration
  def change
    create_table :groupes do |t|
      t.string :nom
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end

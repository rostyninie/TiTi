class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.string :config_k
      t.string :config_value

      t.timestamps
    end
  end
end

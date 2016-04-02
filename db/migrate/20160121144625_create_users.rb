class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :compte
      t.string :nom
      t.string :prenom
      t.string :tel
      t.date :date_naissance
      t.integer :groupe_id
      t.string :passe
      t.boolean :is_active
      t.string :photo_content_type
      t.string :photo_file_name
      t.integer :photo_file_size

      t.timestamps
    end
  end
end

class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :image
      t.integer :score, :default => 0, :null => false

      t.timestamps null: false
    end
  end
end

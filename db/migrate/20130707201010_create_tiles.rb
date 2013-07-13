class CreateTiles < ActiveRecord::Migration
  def change
    create_table :tiles do |t|
      t.integer :template_id
      t.integer :datarow
      t.integer :datacol
      t.integer :datasizex
      t.integer :datasizey
      t.integer :tile_num

      t.timestamps
    end
  end
end

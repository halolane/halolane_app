class AddHeightAndWidthToTiles < ActiveRecord::Migration
  def change
    add_column :tiles, :height, :integer
    add_column :tiles, :width, :integer
    remove_column :tiles, :tile_type
  end
end

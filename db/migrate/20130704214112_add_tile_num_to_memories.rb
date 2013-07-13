class AddTileNumToMemories < ActiveRecord::Migration
  def change
    add_column :memories, :tile_num, :integer
  end
end

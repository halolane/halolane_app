class AddChapterIdToMemories < ActiveRecord::Migration
  def change
    add_column :memories, :chapter_id, :integer
  end
end

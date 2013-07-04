class RemoveChapterIdFromMemories < ActiveRecord::Migration
  def up
  	remove_index :memories, :column => [:user_id,:profile_id,:created_at]
  	remove_column :memories, :chapter_id
  end

  def down
  end
end

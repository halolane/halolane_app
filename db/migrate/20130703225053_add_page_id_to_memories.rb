class AddPageIdToMemories < ActiveRecord::Migration
  def change
    add_column :memories, :page_id, :integer
  end
end

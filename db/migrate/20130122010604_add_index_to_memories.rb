class AddIndexToMemories < ActiveRecord::Migration
  def change
    add_index :memories, [:user_id, :created_at]
  end
end

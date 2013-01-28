class AddProfileIdToMemories < ActiveRecord::Migration
  def change
    add_column :memories, :profile_id, :integer
    add_index :memories, [:user_id, :profile_id, :created_at]
  end
end

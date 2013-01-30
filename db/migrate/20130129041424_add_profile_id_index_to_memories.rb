class AddProfileIdIndexToMemories < ActiveRecord::Migration
  def change
  	add_index :memories, [:profile_id, :created_at]
  end
end

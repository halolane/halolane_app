class AddUserProfileCreatedIndexToMemories < ActiveRecord::Migration
  def change
  	add_index :memories, ["user_id", "profile_id", "created_at"], :name => 'index_memories_on_user_profile_created'
  end
end

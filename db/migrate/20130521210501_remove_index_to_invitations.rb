class RemoveIndexToInvitations < ActiveRecord::Migration
  def up
  	remove_index :invitations, [:profile_id, :recipient_email]
  end

  def down
  	add_index :invitations, [:profile_id, :recipient_email], unique: true
  end
end

class AddIndexToInvitations < ActiveRecord::Migration
  def change
  	add_index :invitations, [:profile_id, :recipient_email], unique: true
  end
end

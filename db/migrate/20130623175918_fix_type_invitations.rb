class FixTypeInvitations < ActiveRecord::Migration
  def up
 		rename_column :invitations, :type, :invite_type
  end

  def down
  end
end

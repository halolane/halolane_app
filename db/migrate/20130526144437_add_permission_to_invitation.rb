class AddPermissionToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :permission, :string
  end
end

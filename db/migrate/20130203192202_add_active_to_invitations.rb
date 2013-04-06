class AddActiveToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :active, :boolean
  end
end

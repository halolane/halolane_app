class AddPermissionToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :permission, :string
  end
end

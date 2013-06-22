class AddOwnerToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :owner, :boolean
  end
end

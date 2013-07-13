class AddDescriptionToMemories < ActiveRecord::Migration
  def change
    add_column :memories, :description, :string
  end
end

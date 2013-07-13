class AddTitleToMemories < ActiveRecord::Migration
  def change
    add_column :memories, :title, :string
  end
end

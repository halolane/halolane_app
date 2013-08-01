class ChangeContentOfMemory < ActiveRecord::Migration
  def up
  	change_column :memories, :content, :text, :limit => nil
  end

  def down
  end
end

class DropTimestampfromuseractionlog < ActiveRecord::Migration
  def up
  	remove_column :useractionlogs, :timestamp
  end

  def down
  end
end

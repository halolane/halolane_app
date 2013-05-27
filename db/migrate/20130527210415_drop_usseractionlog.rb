class DropUsseractionlog < ActiveRecord::Migration
  def up 
  	drop_table :usseractionlogs
  end

  def down
  end
end

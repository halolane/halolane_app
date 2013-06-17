class AddDateToMemory < ActiveRecord::Migration
  def change
    add_column :memories, :date, :date
  end
end

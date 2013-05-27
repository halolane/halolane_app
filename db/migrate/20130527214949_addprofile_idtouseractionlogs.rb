class AddprofileIdtouseractionlogs < ActiveRecord::Migration
  def up
  	add_column :useractionlogs, :profile_id, :integer
  end

  def down
  end
end

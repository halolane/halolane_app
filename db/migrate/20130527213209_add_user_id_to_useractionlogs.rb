class AddUserIdToUseractionlogs < ActiveRecord::Migration
  def change
    add_column :useractionlogs, :user_id, :integer
    add_column :useractionlogs, :pages, :string
    add_column :useractionlogs, :action, :string
    add_column :useractionlogs, :timestamp, :datetime
  end
end

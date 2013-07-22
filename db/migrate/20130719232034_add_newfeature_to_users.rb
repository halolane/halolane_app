class AddNewfeatureToUsers < ActiveRecord::Migration
  def change
    add_column :users, :newfeature, :boolean
  end
end

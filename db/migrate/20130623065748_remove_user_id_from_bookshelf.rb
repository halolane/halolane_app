class RemoveUserIdFromBookshelf < ActiveRecord::Migration
  def up
  	remove_column :bookshelves, :user_id
  end

  def down
  end
end

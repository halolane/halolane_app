class AddBookshelfIdToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :bookshelf_id, :integer
    add_column :profiles, :user_id, :integer
  end
end

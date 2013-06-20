class AddDescriptionToBookshelf < ActiveRecord::Migration
  def change
    add_column :bookshelves, :description, :string
  end
end

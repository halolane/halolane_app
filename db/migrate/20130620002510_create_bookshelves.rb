class CreateBookshelves < ActiveRecord::Migration
  def change
    create_table :bookshelves do |t|
      t.string :name
      t.integer :user_id
      t.integer :privacy

      t.timestamps
    end
  end
end

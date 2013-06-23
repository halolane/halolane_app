class CreateBookshelfrelations < ActiveRecord::Migration
  def change
    create_table :bookshelfrelations do |t|
      t.integer :user_id
      t.integer :bookshelf_id
      t.string :permission
      t.boolean :owner

      t.timestamps
    end
    add_index :bookshelfrelations, :user_id
    add_index :bookshelfrelations, :bookshelf_id
    add_index :bookshelfrelations, [:user_id, :bookshelf_id], unique: true
  end
end

class AddBookshelfIdToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :bookshelf_id, :integer
    add_column :invitations, :type, :string
  end
end

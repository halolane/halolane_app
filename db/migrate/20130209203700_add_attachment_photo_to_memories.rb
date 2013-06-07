class AddAttachmentPhotoToMemories < ActiveRecord::Migration
  def self.up
    add_column :memories, :photo_file_name, :string
    add_column :memories, :photo_content_type, :string
    add_column :memories, :photo_file_size, :integer
    add_column :memories, :photo_updated_at, :datetime
  end

  def self.down
    remove_column :memories, :photo_file_name
    remove_column :memories, :photo_content_type
    remove_column :memories, :photo_file_size
    remove_column :memories, :photo_updated_at
  end
end

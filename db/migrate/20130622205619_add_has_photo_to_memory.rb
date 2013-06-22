class AddHasPhotoToMemory < ActiveRecord::Migration
  def change
    add_column :memories, :has_photo, :boolean
  end
end

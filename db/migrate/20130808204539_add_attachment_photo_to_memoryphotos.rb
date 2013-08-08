class AddAttachmentPhotoToMemoryphotos < ActiveRecord::Migration
  def self.up
    change_table :memoryphotos do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :memoryphotos, :photo
  end
end

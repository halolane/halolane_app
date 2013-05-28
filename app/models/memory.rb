# == Schema Information
#
# Table name: memories
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Memory < ActiveRecord::Base
  
  attr_accessible :content, :profile_id, :photo
  has_attached_file :photo, 
        :storage => :s3, 
        :s3_credentials => "config/s3.yml"


  belongs_to :user
  belongs_to :profile

  validate :content_and_photo_not_blank
  validates :user_id, presence: true  
  validates :profile_id, presence: true
  validates :content, :length => { :maximum => 250 }
  
  validates_attachment :photo,
  :content_type => { :content_type => /image/ },
  :size => { :in => 0..5.megabytes }


  # Sorts it by created_at descending
  default_scope order: 'memories.created_at DESC'

  private

    def content_and_photo_not_blank
      if photo_file_name.nil? and content.blank?
        self.errors.add :base, 'My string can not be nil'
      end
    end

end

class Chapter < ActiveRecord::Base
  attr_accessible :chapter_name, :chapter_num, :profile_id
  
  belongs_to :profile
  has_many :memories, dependent: :destroy

  validates :chapter_num, presence: true
  validates :profile_id, presence: true

end

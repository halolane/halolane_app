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
  attr_accessible :content, :profile_id
  
  belongs_to :user
  belongs_to :profile

  validates :user_id, presence: true  
  validates :profile_id, presence: true
  validates :content, presence: true, :length => { :maximum => 255 }

  # Sorts it by created_at descending
  default_scope order: 'memories.created_at DESC'
end

class Likememory < ActiveRecord::Base
  attr_accessible :memory_id, :user_id
  belongs_to :user
  belongs_to :memory

  validates :user_id, presence: true 
  validates :memory_id, presence: true 
end

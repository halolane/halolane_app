class Storycomment < ActiveRecord::Base
  attr_accessible :content, :memory_id

  belongs_to :user
  belongs_to :memory
  validates :content, presence: true
end

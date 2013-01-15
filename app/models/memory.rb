class Memory < ActiveRecord::Base
  attr_accessible :content, :user_id
  
  belongs_to :user

  validates :content, :length => { :maximum => 255 }
end

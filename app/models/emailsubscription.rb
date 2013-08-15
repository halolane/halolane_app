class Emailsubscription < ActiveRecord::Base
  attr_accessible :emailperweek, :user_id
  validates :user_id, presence: true  
end

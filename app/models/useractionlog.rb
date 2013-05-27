class Useractionlog < ActiveRecord::Base
   attr_accessible :user_id, :page, :action, :timestamp
	belongs_to :user
end

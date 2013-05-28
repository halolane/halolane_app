class Useractionlog < ActiveRecord::Base
   	attr_accessible :user_id, :pages, :action, :timestamp, :profile_id
	belongs_to :user
end

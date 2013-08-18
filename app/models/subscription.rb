class Subscription < ActiveRecord::Base
  attr_accessible :user_id, :plan_id, :profile_id, :stripe_customer_token
  belongs_to :plan
  belongs_to :profile
  validates_presence_of :plan_id
  
end

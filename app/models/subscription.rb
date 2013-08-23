class Subscription < ActiveRecord::Base
  attr_accessible :user_id, :plan_id, :profile_id, :stripe_customer_token, :current_period_start, :current_period_end
  belongs_to :plan
  belongs_to :profile
  validates_presence_of :plan_id
  
end

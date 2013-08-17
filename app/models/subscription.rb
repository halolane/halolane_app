class Subscription < ActiveRecord::Base
  attr_accessible :email, :plan_id, :profile_id, :stripe_customer_token
  belongs_to :plan
  validates_presence_of :plan_id
end

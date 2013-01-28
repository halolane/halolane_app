class Relationship < ActiveRecord::Base
  attr_accessible :profile_id, :user_id, :description

  belongs_to :user
  belongs_to :profile

  validates :profile_id, presence: true
  validates :user_id, presence: true
end

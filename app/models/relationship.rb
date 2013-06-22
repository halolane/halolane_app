class Relationship < ActiveRecord::Base
  attr_accessible :profile_id, :description, :profile_admin, :permission, :owner

  belongs_to :user
  belongs_to :profile

  validates :profile_id, presence: true
  validates :user_id, presence: true

  validates_inclusion_of :permission, :in => ["edit", "contribute", "view"], :allow_nil => true
  

  validates_uniqueness_of :profile_id, :scope => :user_id
end

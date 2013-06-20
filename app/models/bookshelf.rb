class Bookshelf < ActiveRecord::Base
  attr_accessible :name, :privacy, :user_id
	
  belongs_to :user
	has_many :profiles, dependent: :destroy

	validates :name, presence: true
	validates :user_id, presence: true  
	
	validates_numericality_of :privacy, :greater_than_or_equal_to => 0,
                            :only_integer => true, :allows_nil => false

end

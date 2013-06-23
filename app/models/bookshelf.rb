class Bookshelf < ActiveRecord::Base
  attr_accessible :name, :privacy, :user_id
	
  belongs_to :user
	has_many :profiles, dependent: :destroy

	
	validates_numericality_of :privacy, :greater_than_or_equal_to => 0,
                            :only_integer => true, :allows_nil => false

  def getstorybooks
    Profile.where("bookshelf_id = ?", id)
  end

end

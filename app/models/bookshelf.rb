class Bookshelf < ActiveRecord::Base
  attr_accessible :name, :privacy
	
	has_many :profiles, dependent: :destroy
  has_many :bookshelfrelations, dependent: :destroy
  has_many :users, through: :bookshelfrelations
  has_many :invitations, dependent: :destroy
	
	validates_numericality_of :privacy, :greater_than_or_equal_to => 0,
                            :only_integer => true, :allows_nil => false

  def getstorybooks
    Profile.where("bookshelf_id = ?", id)
  end

end
